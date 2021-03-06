<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ruleml="http://ruleml.org/spec">
  <!-- dc:rights [ 'Copyright 2015 RuleML Inc. - Licensed under the RuleML Specification License, Version 1.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://ruleml.org/licensing/RSL1.0-RuleML. Disclaimer: THIS SPECIFICATION IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, ..., EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. See the License for the specifics governing permissions and limitations under the License.' ] -->
  <!-- dc:description [ 'Transformation to correct incomplete termination in instance generation by post-processing. 
       Target schema is normalized or relaxed serialization. ' ] -->
  <xsl:template match="ruleml:do[not(*)]"/>  
  <!-- Changes each key and xml:id value to a unique value -->
  <xsl:template match="@key">
      <xsl:attribute name="key" select="concat(':', generate-id())"/>
  </xsl:template>
  <xsl:template match="@xml:id">
    <xsl:attribute name="xml:id" select="generate-id()"/>
  </xsl:template>
  
  <xsl:template match="ruleml:guard[not(*)]"/>
  
  <xsl:template match="ruleml:signature[not(*)]"/>
  
  <xsl:template match="ruleml:qualification[not(*)]"/>
  
  <xsl:template match="ruleml:testbase[not(*)]">
    <xsl:copy>
      <ruleml:Assert/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="ruleml:enclosed[not(*)]">
    <xsl:copy>
      <ruleml:Message/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="ruleml:expectedResult[not(*)]">
    <xsl:copy>
      <ruleml:Answer/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="ruleml:*[matches(local-name(.), '^if$|^then$|^else$|^after$')][not(*)]">
    <xsl:copy>
      <ruleml:Atom/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="ruleml:*[matches(local-name(.), '^Holds$')][ruleml:at[count(preceding-sibling::ruleml:fluent)=0]]">
    <xsl:copy>      
      <xsl:apply-templates select="@*"/>
      <ruleml:fluent>
      <ruleml:Data/>
    </ruleml:fluent>
    <xsl:apply-templates select="ruleml:at"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="ruleml:*[matches(local-name(.), '^Initiates$|^Terminates$')][ruleml:at[count(preceding-sibling::ruleml:fluent)=0 or count(preceding-sibling::ruleml:on)=0 ]]">
    <xsl:copy>      
      <xsl:apply-templates select="@*"/>
      <ruleml:on>
        <ruleml:Event/>
      </ruleml:on>
      <ruleml:fluent>
        <ruleml:Data/>
      </ruleml:fluent>
      <xsl:apply-templates select="ruleml:at"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="ruleml:*[matches(local-name(.), '^Initiates$|^Terminates$')][not(ruleml:at)][ruleml:fluent[count(preceding-sibling::ruleml:on)=0 ]]">
    <xsl:copy>      
      <xsl:apply-templates select="@*"/>
      <ruleml:on>
        <ruleml:Event/>
      </ruleml:on>
      <xsl:apply-templates select="ruleml:fluent"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="ruleml:*[matches(local-name(.), '^Initiates$|^Terminates$')][not(ruleml:at)][not(ruleml:fluent)][ruleml:on]">
    <xsl:copy>      
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="ruleml:on"/>
      <ruleml:fluent>
        <ruleml:Data/>
      </ruleml:fluent>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="ruleml:*[matches(local-name(.), '^Not$|^Aperiodic$|^Happens$|^Periodic$')][ruleml:at[count(preceding-sibling::ruleml:on)=0]]">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <ruleml:on>
      <ruleml:Event/>
    </ruleml:on>
      <xsl:apply-templates select="ruleml:at"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="ruleml:*[matches(local-name(.), '^Do$')][ruleml:at[count(preceding-sibling::ruleml:do)=0]]">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <ruleml:do>
      <ruleml:Action/>
    </ruleml:do>
      <xsl:apply-templates select="ruleml:at"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="ruleml:*[matches(local-name(.), '^TestItem$')][count(*) &lt; 2]">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <ruleml:Answer/>
      <ruleml:Answer/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="ruleml:conent/ruleml:Operation">    
  <xsl:copy>
    <xsl:apply-templates select="@*"/>
    <ruleml:formula>
      <ruleml:Atom>
        <ruleml:op><ruleml:Rel/></ruleml:op>
      </ruleml:Atom>
    </ruleml:formula>
  </xsl:copy>
  </xsl:template>
  
</xsl:stylesheet>
