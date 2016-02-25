<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ruleml="http://ruleml.org/spec" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0">
  <!-- dc:rights [ 'Copyright 2015 RuleML Inc. - Licensed under the RuleML Specification License, Version 1.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://ruleml.org/licensing/RSL1.0-RuleML. Disclaimer: THIS SPECIFICATION IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, ..., EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. See the License for the specifics governing permissions and limitations under the License.' ] -->
  <!-- Functions -->
  <!-- test for Allen Operator elements-->
  <xsl:function name="ruleml:isAllen" as="xs:boolean">
    <xsl:param name="node" as="node()"/>
    <xsl:value-of
      select="namespace-uri($node)='http://ruleml.org/spec' and
      (
      matches(local-name($node), 'Precedes') or
      matches(local-name($node), 'Meets') or
      matches(local-name($node), 'Starts') or
      matches(local-name($node), 'During') or
      matches(local-name($node), 'Equal') or
      matches(local-name($node), 'Overlaps') or
      matches(local-name($node), 'Finishes') or
      matches(local-name($node), 'Succeeds')
      )
      "
    />
  </xsl:function>

  <!-- Renames <act> edges to <do> -->
  <xsl:template match="ruleml:act">
    <xsl:element name="ruleml:do">
      <xsl:apply-templates select="@*|node()"/>      
    </xsl:element>
  </xsl:template>
  
  <!-- Renames <Operator> Nodes to <Operation> -->
  <xsl:template match="ruleml:Operator">
    <xsl:element name="ruleml:Operation">
      <xsl:apply-templates select="@*|node()"/>      
    </xsl:element>
  </xsl:template>
  
  <!-- Removes wrappers from Allen Operators -->
  <xsl:template match="ruleml:Interval[ruleml:*[ruleml:isAllen(.)]]">
    <xsl:apply-templates select="node()"/>     
  </xsl:template>

  <xsl:template match="ruleml:Interval[ruleml:arg/ruleml:*[ruleml:isAllen(.)]]">
    <xsl:apply-templates select="node()"/>      
  </xsl:template>
  
  <xsl:template match="ruleml:Interval/ruleml:arg[ruleml:*[ruleml:isAllen(.)]]">
    <xsl:apply-templates select="node()"/>      
  </xsl:template>
  
  <!-- Changes arg within Equal to left or right -->
  <xsl:template match="ruleml:Equal/ruleml:arg[@index='1' or (not(@index) and position()=1)]">
    <xsl:element name="ruleml:left">
      <xsl:apply-templates select="node()"/>      
    </xsl:element>
  </xsl:template>
  <xsl:template match="ruleml:Equal/ruleml:arg[@index='2' or (not(@index) and position()=2)]">
    <xsl:element name="ruleml:right">
      <xsl:apply-templates select="node()"/>      
    </xsl:element>
  </xsl:template>
  
  <!-- Updates the version in the xml-model processing instruction  -->
  <xsl:template match="/processing-instruction('xml-model')">
    <xsl:variable name="text">
      <xsl:value-of select="."/>
    </xsl:variable>
    <xsl:processing-instruction name="xml-model"><xsl:value-of select="replace($text, '1.0', '1.02' )"/></xsl:processing-instruction>
  </xsl:template>

  <!-- Updates the version in the xsi:schemaLocation attribute-->
  <xsl:template match="@xsi:schemaLocation">
    <xsl:attribute name="xsi:schemaLocation" select="replace(., '1.0', '1.02')"/>
  </xsl:template>



  <!-- Copies everything to the transformation output -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
