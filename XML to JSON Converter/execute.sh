#!/bin/bash
mkdir -p out
xml=$(cat src/data.xml)
# Escape properly and use xmllint + xsltproc (available in environment)
echo "$xml" | xmllint --format - | xsltproc <(cat <<'EOF'
<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text"/>
  <xsl:template match="/"><xsl:apply-templates/></xsl:template>
  <xsl:template match="*">
    <xsl:text>{"</xsl:text><xsl:value-of select="name()"/><xsl:text>":</xsl:text>
    <xsl:choose>
      <xsl:when test="count(*)=0 and not(@*)"><xsl:text>"</xsl:text><xsl:value-of select="."/><xsl:text>"</xsl:text></xsl:when>
      <xsl:when test="count(*)>0 or @*">
        <xsl:text>{</xsl:text>
        <xsl:for-each select="@*">
          <xsl:text>"@</xsl:text><xsl:value-of select="name()"/><xsl:text>":"</xsl:text><xsl:value-of select="."/><xsl:text>"</xsl:text>
          <xsl:if test="position()!=last()">,</xsl:if>
        </xsl:for-each>
        <xsl:if test="@* and *">,</xsl:if>
        <xsl:for-each select="*">
          <xsl:if test="position()>1">,</xsl:if>
          <xsl:apply-templates select="."/>
        </xsl:for-each>
        <xsl:text>}</xsl:text>
      </xsl:when>
    </xsl:choose>
    <xsl:text>}</xsl:text>
  </xsl:template>
</xsl:stylesheet>
EOF
) - | sed 's/}{/},{/g; s/}$/]/; s/{$/[/;' > out/output.json