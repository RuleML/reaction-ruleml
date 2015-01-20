<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://ruleml.org/spec"
    xmlns:r="http://ruleml.org/spec" exclude-result-prefixes="#all">
    
    <!-- Remove almost all white space between elements -->
    <xsl:preserve-space elements="RuleML"/>
    <xsl:strip-space elements="*"/>
    
    <!-- Add the  <?xml version="1.0" ?> at the top of the result.-->
    <xsl:output method="xml" version="1.0" indent="no" exclude-result-prefixes="r"/>
    
    <!-- Phase I: insert stripes if skipped -->
    <xsl:variable name="phase-1-output">
        <xsl:apply-templates select="/" mode="phase-1"/>
    </xsl:variable>

    <!-- Wraps the naked RuleML children of RuleML. -->
    <xsl:template match="r:RuleML/*[namespace-uri(.)='http://ruleml.org/spec' and not(matches(local-name(.),'^[a-z].*'))]" mode="phase-1">
        <xsl:call-template name="wrap">
            <xsl:with-param name="tag">act</xsl:with-param>
        </xsl:call-template>
    </xsl:template>


    <!-- Wraps the naked RuleML children of Assert. -->
    <xsl:template match="r:Assert/*[namespace-uri(.)='http://ruleml.org/spec' and not(matches(local-name(.),'^[a-z].*'))]" mode="phase-1">
        <xsl:call-template name="wrap">
            <xsl:with-param name="tag">formula</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <!-- Wraps the naked RuleML children of Rulebase. -->
    <xsl:template match="r:Rulebase/*[namespace-uri(.)='http://ruleml.org/spec' and not(matches(local-name(.),'^[a-z].*'))]" mode="phase-1">
        <xsl:call-template name="wrap">
            <xsl:with-param name="tag">formula</xsl:with-param>
        </xsl:call-template>
    </xsl:template>   
    
    <!-- Wraps the naked RuleML children of Equivalent. -->
    <xsl:template match="r:Equivalent/*[namespace-uri(.)='http://ruleml.org/spec' and not(matches(local-name(.),'^[a-z].*'))]" mode="phase-1">
        <xsl:call-template name="wrap">
            <xsl:with-param name="tag">torso</xsl:with-param>
        </xsl:call-template>
    </xsl:template>   
    
    <!-- Wraps the naked RuleML children of Retract. -->
    <xsl:template
        match="r:Retract/*[namespace-uri(.)='http://ruleml.org/spec' and not(matches(local-name(.),'^[a-z].*'))]"
        mode="phase-1">
        <xsl:call-template name="wrap">
            <xsl:with-param name="tag">formula</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    
    <!-- Wraps the naked RuleML children of Query. -->
    <xsl:template
        match="r:Query/*[namespace-uri(.)='http://ruleml.org/spec' and not(matches(local-name(.),'^[a-z].*'))]"
        mode="phase-1">
        <xsl:call-template name="wrap">
            <xsl:with-param name="tag">formula</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    
    <!-- Wraps the naked RuleML children of And.-->
    <xsl:template
        match="r:And/*[namespace-uri(.)='http://ruleml.org/spec' and not(matches(local-name(.),'^[a-z].*'))]"
        mode="phase-1">
        <xsl:call-template name="wrap">
            <xsl:with-param name="tag">formula</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <!-- Wraps the naked RuleML children of Or.-->
    <xsl:template
        match="r:Or/*[namespace-uri(.)='http://ruleml.org/spec' and not(matches(local-name(.),'^[a-z].*'))]"
        mode="phase-1">
        <xsl:call-template name="wrap">
            <xsl:with-param name="tag">formula</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <!-- Wraps the naked RuleML children of Neg. -->
    <xsl:template
        match="r:Neg/*[namespace-uri(.)='http://ruleml.org/spec' and not(matches(local-name(.),'^[a-z].*'))]"
        mode="phase-1">
        <xsl:call-template name="wrap">
            <xsl:with-param name="tag">strong</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <!-- Wraps the naked RuleML children of Naf. -->
    <xsl:template
        match="r:Naf/*[namespace-uri(.)='http://ruleml.org/spec' and not(matches(local-name(.),'^[a-z].*'))]"
        mode="phase-1">
        <xsl:call-template name="wrap">
            <xsl:with-param name="tag">weak</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <!-- Wraps the naked RuleML children of Equal in the cases where:
        -the only children of Equal are <left>, <right> and <oid> which can appear before <left> and <right> - does not handle foreign elements in the last or second to last position
        -if both children are already wrapped then they will be copied unchanged
        -neither children are wrapped, then the second to last child is wrapped in <left> and the last child is wrapped <right>
        -the second to last child is wrapped in <right>, and the last child is not wrapped, then the last child is wrapped in <left>, in all other cases,
        the last child is wrapped in <right>
        -the last child is wrapped in <left> and the second to last child is not wrapped, then the second to last child is wrapped in <right>,
        in all other cases, the second to last child is wrapped in <left>
        Does not normalize cases where:
        -there are foreign elements as the last or second to last child
        -there are foreign elements between the last and second to last child
       
    -->
    <!-- Wraps the second to last RuleML child of Equal. -->
    <xsl:template match="r:Equal/*[namespace-uri(.)='http://ruleml.org/spec' and position()=last()-1]" mode="phase-1">
        <xsl:choose>
            <xsl:when test="local-name()='left' or local-name()='right'">
                <xsl:call-template name="copy-1" />
            </xsl:when>
            <xsl:when test="local-name(following-sibling::*[1])='left'">
                <xsl:call-template name="wrap">
                    <xsl:with-param name="tag">right</xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="wrap">
                    <xsl:with-param name="tag">left</xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <!-- Wraps the last RuleML child of Equal. -->
    <xsl:template match="r:Equal/*[namespace-uri(.)='http://ruleml.org/spec' and position()=last()]" mode="phase-1"> 
        <xsl:choose>
            <xsl:when test="local-name()='left' or local-name()='right'">
                <xsl:call-template name="copy-1" />
            </xsl:when>
            <xsl:when test="local-name(preceding-sibling::*[1])='right'">
                <xsl:call-template name="wrap">
                    <xsl:with-param name="tag">left</xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="wrap">
                    <xsl:with-param name="tag">right</xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
            
    <!-- Wraps the naked RuleML childern of Atom. -->
    <xsl:template match="r:Atom/*[namespace-uri(.)='http://ruleml.org/spec' and not(matches(local-name(.),'^[a-z].*'))]" mode="phase-1">
        <xsl:choose>
            <xsl:when test="local-name()='Rel'">
                <xsl:call-template name="wrap">
                    <xsl:with-param name="tag">op</xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="wrap">
                    <xsl:with-param name="tag">arg</xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
  
  <!-- Wraps the naked RuleML childern of Time. -->
  <xsl:template match="r:Time/*[namespace-uri(.)='http://ruleml.org/spec' and not(matches(local-name(.),'^[a-z].*'))]" mode="phase-1">
        <xsl:call-template name="wrap">
          <xsl:with-param name="tag">arg</xsl:with-param>
        </xsl:call-template>
  </xsl:template>
  
  <!-- Wraps the naked RuleML childern of Spatial. -->
  <xsl:template match="r:Spatial/*[namespace-uri(.)='http://ruleml.org/spec' and not(matches(local-name(.),'^[a-z].*'))]" mode="phase-1">
    <xsl:call-template name="wrap">
      <xsl:with-param name="tag">arg</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <!-- Wraps the naked RuleML childern of Interval. -->
  <xsl:template match="r:Interval/*[namespace-uri(.)='http://ruleml.org/spec' and not(matches(local-name(.),'^[a-z].*'))]" mode="phase-1">
    <xsl:call-template name="wrap">
      <xsl:with-param name="tag">arg</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
    <!-- Wraps the naked RuleML children of Implies in the cases where:
        -the only children of Implies are <left>, <right> and <oid> which can appear before <if> and <then> - does not handle foreign elements in the last or second to last position
        -if both children are already wrapped then they will be copied unchanged
        -neither children are wrapped, then the second to last child is wrapped in <if> and the last child is wrapped <then>
        -the second to last child is wrapped in <then>, and the last child is not wrapped, then the last child is wrapped in <if>, in all other cases,
        the last child is wrapped in <then>
        -the last child is wrapped in <if> and the second to last child is not wrapped, then the second to last child is wrapped in <then>,
        in all other cases, the second to last child is wrapped in <if>
        Does not normalize cases where:
        -there are foreign elements as the last or second to last child
        -there are foreign elements between the last and second to last child
    -->
    
    <!-- Wraps the second to last RuleML child of Implies or Entails. -->
    <xsl:template match="r:Implies/*[namespace-uri(.)='http://ruleml.org/spec' and position()=last()-1]|
     r:Entails/*[namespace-uri(.)='http://ruleml.org/spec'
       and position()=last()-1]" mode="phase-1">
        <xsl:comment>second to last</xsl:comment>
        <xsl:choose>
            <xsl:when test="local-name()='if' or local-name()='then'">
                <xsl:call-template name="copy-1" />
            </xsl:when>
            <xsl:when test="local-name(following-sibling::*[1])='if'">
                <xsl:call-template name="wrap">
                    <xsl:with-param name="tag">then</xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="wrap">
                    <xsl:with-param name="tag">if</xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
        
    <!-- Wraps the last RuleML child of Implies or Entails. -->
    <xsl:template match="r:Implies/*[namespace-uri(.)='http://ruleml.org/spec' and position()=last()]|
     r:Entails/*[namespace-uri(.)='http://ruleml.org/spec'
       and position()=last()]" mode="phase-1">
        <xsl:comment>last</xsl:comment>
        <xsl:choose>
            <xsl:when test="local-name()='if' or local-name()='then'">
                <xsl:call-template name="copy-1" />
            </xsl:when>
            <xsl:when test="local-name(preceding-sibling::*[1])='then'">
                <xsl:call-template name="wrap">
                    <xsl:with-param name="tag">if</xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="wrap">
                    <xsl:with-param name="tag">then</xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <!-- Wraps the naked RuleML children of Forall. -->
    <xsl:template match="r:Forall/*[namespace-uri(.)='http://ruleml.org/spec' and not(matches(local-name(.),'^[a-z].*'))]" mode="phase-1">
        <xsl:choose>
            <xsl:when test="local-name(.)='Var'">
                <xsl:call-template name="wrap">
                    <xsl:with-param name="tag">declare</xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="wrap">
                    <xsl:with-param name="tag">formula</xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Wraps the naked RuleML children of Exists. -->
    <xsl:template match="r:Exists/*[namespace-uri(.)='http://ruleml.org/spec' and not(matches(local-name(.),'^[a-z].*'))]" mode="phase-1">
        <xsl:choose>
            <xsl:when test="local-name(.)='Var'">
                <xsl:call-template name="wrap">
                    <xsl:with-param name="tag">declare</xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="wrap">
                    <xsl:with-param name="tag">formula</xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
        
    <!-- Wraps the naked children of Expr -->
    <xsl:template match="r:Expr/*[namespace-uri(.)='http://ruleml.org/spec' and not(matches(local-name(.),'^[a-z].*'))]" mode="phase-1">
        <xsl:choose>
            <xsl:when test="local-name()='Fun'">
                <xsl:call-template name="wrap">
                    <xsl:with-param name="tag">op</xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="wrap">
                    <xsl:with-param name="tag">arg</xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Wraps the naked children of Plex. -->
    <xsl:template match="r:Plex/*[namespace-uri(.)='http://ruleml.org/spec' and not(matches(local-name(.),'^[a-z].*'))]" mode="phase-1">
        <xsl:call-template name="wrap">
            <xsl:with-param name="tag">arg</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    
    
    <!-- Named template that wraps an element in the element given by the tag parameter. -->
    <xsl:template name="wrap">
        <xsl:param name="tag" />
        <xsl:element name="{$tag}">
            <xsl:call-template name="copy-1" />
        </xsl:element>
    </xsl:template>
    
    

    
    
    <!-- Copies everything else to the phase-1 output. Comments are preserved without escaping.
        Order is preserved.
        Foreign elements are preserved.
        Because this is the most general of all templates, any more specific template in phase-1 will over-ride this one.  -->
    
    <xsl:template match="node() | @*" mode="phase-1">
        <xsl:call-template name="copy-1"/>
    </xsl:template>
    
    <xsl:template name="copy-1">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="phase-1"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Phase II: rearrange into canonical ordering -->
    
    <xsl:variable name="phase-2-output">
        <xsl:apply-templates select="$phase-1-output" mode="phase-2"/>
    </xsl:variable>
    
       
    <!-- Note: Some of these templates may be combined. -->
    <!-- Builds canonically-ordered content of Retract. -->
    <xsl:template match="r:Retract" mode="phase-2">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates 
              select="*[namespace-uri(.)!='http://ruleml.org/spec']" mode="phase-2"/>
            <xsl:apply-templates select="r:meta" mode="phase-2"/>
            <xsl:apply-templates select="*[namespace-uri(.)='http://ruleml.org/spec' and
              (local-name()!= 'meta' and local-name()!= 'formula')]" mode="phase-2"/>
            <xsl:apply-templates select="r:formula" mode="phase-2"/>
        </xsl:copy> 
    </xsl:template>
    <!-- Builds canonically-ordered content of Query. -->
    <xsl:template match="r:Query" mode="phase-2">
        <xsl:copy>
            <xsl:apply-templates 
              select="*[namespace-uri(.)!='http://ruleml.org/spec']" mode="phase-2"/>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates 
              select="*[namespace-uri(.)!='http://ruleml.org/spec']" mode="phase-2"/>
            <xsl:apply-templates select="r:meta" mode="phase-2"/>
            <xsl:apply-templates select="*[namespace-uri(.)='http://ruleml.org/spec' and
              (local-name()!= 'meta' and local-name()!= 'formula')]" mode="phase-2"/>
            <xsl:apply-templates select="r:formula" mode="phase-2"/>
        </xsl:copy>       
    </xsl:template>
    <!-- Builds canonically-ordered content of Entails. -->
    <xsl:template match="r:Entails" mode="phase-2">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates 
              select="*[namespace-uri(.)!='http://ruleml.org/spec']" mode="phase-2"/>
            <xsl:apply-templates select="r:meta" mode="phase-2"/>
            <xsl:apply-templates select="*[namespace-uri(.)='http://ruleml.org/spec' and
              (local-name()!= 'meta' and local-name()!= 'if' 
              and local-name()!= 'then')]" mode="phase-2"/>
            <xsl:apply-templates select="r:if" mode="phase-2"/>
            <xsl:apply-templates select="r:then" mode="phase-2"/>
        </xsl:copy>    
    </xsl:template>
    <!-- Builds canonically-ordered content of Rulebase. -->
    <xsl:template match="r:Rulebase" mode="phase-2">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates 
              select="*[namespace-uri(.)!='http://ruleml.org/spec']" mode="phase-2"/>
            <xsl:apply-templates select="r:meta" mode="phase-2"/>
            <xsl:apply-templates select="*[namespace-uri(.)='http://ruleml.org/spec' and
              (local-name()!= 'meta' and local-name()!= 'formula')]" mode="phase-2"/>
            <xsl:apply-templates select="r:formula" mode="phase-2"/>
        </xsl:copy>
    </xsl:template>
    <!-- Builds canonically-ordered content of Exists. -->
    <xsl:template match="r:Exists" mode="phase-2">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates 
              select="*[namespace-uri(.)!='http://ruleml.org/spec']" mode="phase-2"/>
            <xsl:apply-templates select="r:meta" mode="phase-2"/>
            <xsl:apply-templates select="*[namespace-uri(.)='http://ruleml.org/spec' and
              (local-name()!= 'meta' and local-name()!= 'formula')]" mode="phase-2"/>
            <xsl:apply-templates select="r:formula" mode="phase-2"/>
        </xsl:copy>
    </xsl:template>
    <!-- Builds canonically-ordered content of Forall. -->
    <xsl:template match="r:Forall" mode="phase-2">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates 
              select="*[namespace-uri(.)!='http://ruleml.org/spec']" mode="phase-2"/>
            <xsl:apply-templates select="r:meta" mode="phase-2"/>
            <xsl:apply-templates select="*[namespace-uri(.)='http://ruleml.org/spec' and
              (local-name()!= 'meta' and local-name()!= 'formula')]" mode="phase-2"/>
            <xsl:apply-templates select="r:formula" mode="phase-2"/>
        </xsl:copy>
    </xsl:template>
    <!-- Builds canonically-ordered content of Implies. -->
    <xsl:template match="r:Implies" mode="phase-2">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates 
              select="*[namespace-uri(.)!='http://ruleml.org/spec']" mode="phase-2"/>
            <xsl:apply-templates select="r:meta" mode="phase-2"/>
            <xsl:apply-templates select="*[namespace-uri(.)='http://ruleml.org/spec' and
              (local-name()!= 'meta' and local-name()!= 'if' 
              and local-name()!= 'then')]" mode="phase-2"/>
            <xsl:apply-templates select="r:if" mode="phase-2"/>
            <xsl:apply-templates select="r:then" mode="phase-2"/>
        </xsl:copy>    
    </xsl:template>
    <!-- Builds canonically-ordered content of Equivalent. -->
    <xsl:template match="r:Equivalent" mode="phase-2">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates 
              select="*[namespace-uri(.)!='http://ruleml.org/spec']" mode="phase-2"/>
            <xsl:apply-templates select="r:meta" mode="phase-2"/>
            <xsl:apply-templates select="*[namespace-uri(.)='http://ruleml.org/spec' and
              (local-name()!= 'meta' and local-name()!= 'torso')]" mode="phase-2"/>
            <xsl:apply-templates select="r:torso" mode="phase-2"/>
        </xsl:copy>
    </xsl:template>
    <!-- Builds canonically-ordered content of And.-->
    <xsl:template match="r:And" mode="phase-2">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates 
              select="*[namespace-uri(.)!='http://ruleml.org/spec']" mode="phase-2"/>
            <xsl:apply-templates select="r:meta" mode="phase-2"/>
            <xsl:apply-templates select="*[namespace-uri(.)='http://ruleml.org/spec' and
              (local-name()!= 'meta' and local-name()!= 'formula')]" mode="phase-2"/>
            <xsl:apply-templates select="r:formula" mode="phase-2"/>
        </xsl:copy>
    </xsl:template>
    <!-- Builds canonically-ordered content of Or. -->
    <xsl:template match="r:Or" mode="phase-2">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates 
              select="*[namespace-uri(.)!='http://ruleml.org/spec']" mode="phase-2"/>
            <xsl:apply-templates select="r:meta" mode="phase-2"/>
            <xsl:apply-templates select="*[namespace-uri(.)='http://ruleml.org/spec' and
              (local-name()!= 'meta' and local-name()!= 'formula')]" mode="phase-2"/>
            <xsl:apply-templates select="r:formula" mode="phase-2"/>
        </xsl:copy>
    </xsl:template>
    <!-- Builds canonically-ordered content of Atom. -->
    <xsl:template match="r:Atom" mode="phase-2">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates 
              select="*[namespace-uri(.)!='http://ruleml.org/spec']" mode="phase-2"/>
            <xsl:apply-templates select="r:meta" mode="phase-2"/>
            <xsl:apply-templates select="@*|*[
              namespace-uri(.)='http://ruleml.org/spec' and 
              local-name()!= 'meta' and 
              local-name()!= 'oid' and 
              local-name()!= 'degree' and 
              local-name()!= 'op' and 
              local-name()!= 'arg' and 
              local-name()!='repo' and 
              local-name()!='slot' and 
              local-name()!='resl']" mode="phase-2"/>
            <xsl:apply-templates select="r:oid" mode="phase-2"/>
            <xsl:apply-templates select="r:degree" mode="phase-2"/>
            <xsl:apply-templates select="r:op" mode="phase-2"/>
            <xsl:apply-templates select="r:arg" mode="phase-2"/>            
            <xsl:apply-templates select="r:repo" mode="phase-2"/>
            <xsl:apply-templates select="r:slot" mode="phase-2"/>
            <xsl:apply-templates select="r:resl" mode="phase-2"/>
        </xsl:copy> 
    </xsl:template>
    <!-- Builds canonically-ordered content of Equal. -->
    <xsl:template match="r:Equal" mode="phase-2">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates 
              select="*[namespace-uri(.)!='http://ruleml.org/spec']" mode="phase-2"/>
            <xsl:apply-templates select="r:meta" mode="phase-2"/>
            <xsl:apply-templates select="*[
              namespace-uri(.)='http://ruleml.org/spec' and 
              local-name()!= 'meta' and 
              local-name()!= 'degree' and 
              local-name()!= 'left' and 
              local-name()!= 'right']" mode="phase-2"/>
            <xsl:apply-templates select="r:degree" mode="phase-2"/>
            <xsl:apply-templates select="r:left" mode="phase-2"/>
            <xsl:apply-templates select="r:right" mode="phase-2"/>    
        </xsl:copy> 
    </xsl:template>
    <!-- Builds canonically-ordered content of Neg. -->
    <xsl:template match="r:Neg" mode="phase-2">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates 
              select="*[namespace-uri(.)!='http://ruleml.org/spec']" mode="phase-2"/>
            <xsl:apply-templates select="r:meta" mode="phase-2"/>
            <xsl:apply-templates select="*[namespace-uri(.)='http://ruleml.org/spec' and
              (local-name()!= 'meta' and local-name()!= 'strong')]" mode="phase-2"/>
            <xsl:apply-templates select="r:strong" mode="phase-2"/>
        </xsl:copy>     
    </xsl:template>
    <!-- Builds canonically-ordered content of Naf. -->
    <xsl:template match="r:Naf" mode="phase-2">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates 
              select="*[namespace-uri(.)!='http://ruleml.org/spec']" mode="phase-2"/>
            <xsl:apply-templates select="r:meta" mode="phase-2"/>
            <xsl:apply-templates select="*[namespace-uri(.)='http://ruleml.org/spec' and
              (local-name()!= 'meta' and local-name()!= 'weak')]" mode="phase-2"/>
            <xsl:apply-templates select="r:weak" mode="phase-2"/>
        </xsl:copy>     
    </xsl:template>
    <!-- Builds canonically-ordered content of Expr. -->
    <xsl:template match="r:Expr" mode="phase-2">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates 
              select="*[namespace-uri(.)!='http://ruleml.org/spec']" mode="phase-2"/>
            <xsl:apply-templates select="r:meta" mode="phase-2"/>
            <xsl:apply-templates select="*[
              namespace-uri(.)='http://ruleml.org/spec' and 
              local-name()!= 'meta' and 
              local-name()!= 'oid' and 
              local-name()!= 'op' and 
              local-name()!= 'arg' and 
              local-name()!='repo' and 
              local-name()!='slot' and 
              local-name()!='resl']" mode="phase-2"/>
            <xsl:apply-templates select="r:oid" mode="phase-2"/>
            <xsl:apply-templates select="r:op" mode="phase-2"/>
            <xsl:apply-templates select="r:arg" mode="phase-2"/>
            <xsl:apply-templates select="r:repo" mode="phase-2"/>
            <xsl:apply-templates select="r:slot" mode="phase-2"/>
            <xsl:apply-templates select="r:resl" mode="phase-2"/>
        </xsl:copy>     
    </xsl:template>
    <!-- Builds canonically-ordered content of Plex. -->
    <xsl:template match="r:Plex" mode="phase-2">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates 
              select="*[namespace-uri(.)!='http://ruleml.org/spec']" mode="phase-2"/>
            <xsl:apply-templates select="r:meta" mode="phase-2"/>
            <xsl:apply-templates select="*[
              namespace-uri(.)='http://ruleml.org/spec' and 
              local-name()!= 'meta' and 
              local-name()!= 'oid' and 
              local-name()!= 'arg' and 
              local-name()!='repo' and 
              local-name()!='slot' and 
              local-name()!='resl']" />
            <xsl:apply-templates select="r:oid" mode="phase-2"/>
            <xsl:apply-templates select="r:arg" mode="phase-2"/>
            <xsl:apply-templates select="r:repo" mode="phase-2"/>
            <xsl:apply-templates select="r:slot" mode="phase-2"/>
            <xsl:apply-templates select="r:resl" mode="phase-2"/>
        </xsl:copy>     
    </xsl:template>
    <!-- copy comments-->
    <xsl:template match="comment()">
        <xsl:copy/>
    </xsl:template>
    
    <!-- Copies everything else to the phase-2 output. Comments are preserved without escaping.
        Order is preserved.
        Foreign elements are preserved.
        Because this is the most general of all templates, any more specific template in phase-2 will over-ride this one.  -->
    <xsl:template match="node() | @*" mode="phase-2">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="phase-2"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Phase III: treatment of attributes with default values -->
    
    <xsl:variable name="phase-3-output">
        <xsl:apply-templates select="$phase-2-output" mode="phase-3"/>
    </xsl:variable>
    
  <!-- For Implies -->
  <!-- Makes @material explicit. -->
  <!-- Makes @direction explicit. -->
  <xsl:template match="r:Implies[not(@material) or not(@direction)]" mode="phase-3">
    <xsl:copy>
      <xsl:if test="not(@material)">
        <xsl:attribute name="material">yes</xsl:attribute>
      </xsl:if>
      <xsl:if test="not(@direction)">
        <xsl:attribute name="direction">bidirectional</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="node() | @*" mode="phase-3"/>
    </xsl:copy>
  </xsl:template>
  
  <!-- For Assert -->
  <!-- Makes @mapMaterial explicit. -->
  <!-- Makes @mapDirection explicit. -->
  <xsl:template match="r:Assert[not(@mapMaterial) or not(@mapDirection)]" mode="phase-3">
    <xsl:copy>
      <xsl:if test="not(@mapMaterial)">
        <xsl:attribute name="mapMaterial">yes</xsl:attribute>
      </xsl:if>
      <xsl:if test="not(@mapDirection)">
        <xsl:attribute name="mapDirection">bidirectional</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="node() | @*" mode="phase-3"/>
    </xsl:copy>
  </xsl:template>
  
  <!-- For Retract -->
  <!-- Makes @mapMaterial explicit. -->
  <!-- Makes @mapDirection explicit. -->
  <xsl:template match="r:Retract[not(@mapMaterial) or not(@mapDirection)]" mode="phase-3">
    <xsl:copy>
      <xsl:if test="not(@mapMaterial)">
        <xsl:attribute name="mapMaterial">yes</xsl:attribute>
      </xsl:if>
      <xsl:if test="not(@mapDirection)">
        <xsl:attribute name="mapDirection">bidirectional</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="node() | @*" mode="phase-3"/>
    </xsl:copy>
  </xsl:template>
  
  <!-- Makes @val explicit. -->
    <!-- Makes @per explicit. -->
    <xsl:template match="r:Fun[not(@val)or not(@per)]" mode="phase-3">
        <xsl:copy>
            <xsl:if test="not (@val)">
                <xsl:attribute name="val">0..</xsl:attribute>
            </xsl:if>
            <xsl:if test="not(@per)">
                <xsl:attribute name="per">copy</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="node() | @*" mode="phase-3"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Makes @oriented explicit. -->
    <xsl:template match="r:Equal[not(@oriented)]" mode="phase-3">
        <xsl:copy>
            <xsl:attribute name="oriented">no</xsl:attribute>
            <xsl:apply-templates select="node() | @*" mode="phase-3"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Adds the required index attribute to the arg tag 
        There are errors with the indexing when the argument is within a slot-->
    <xsl:template match="r:arg[namespace-uri(.)='http://ruleml.org/spec']" mode="phase-3">
        <xsl:variable name="index_value">
            <xsl:value-of select="count(preceding-sibling::r:arg)+1" />
        </xsl:variable>
        <arg>
            <xsl:attribute name="index">
                <xsl:value-of select="$index_value" />
            </xsl:attribute>
            <xsl:apply-templates select="node() | @*" mode="phase-3"/>
        </arg>
    </xsl:template>

    <!-- Adds the required index attribute to the act tag -->
    <xsl:template match="r:act[namespace-uri(.)='http://ruleml.org/spec']" mode="phase-3">
        <xsl:variable name="index_value">
            <xsl:value-of select="count(preceding-sibling::r:act)+1" />
        </xsl:variable>
        <act>
            <xsl:attribute name="index">
                <xsl:value-of select="$index_value" />
            </xsl:attribute>
            <xsl:apply-templates select="node() | @*" mode="phase-3"/>
        </act>
    </xsl:template>

    <!-- Copies everything else to the phase-3 output. Comments are preserved without escaping.
        Order is preserved.
        Foreign elements are preserved.
        Because this is the most general of all templates, any more specific template in phase-3 will over-ride this one.  -->
    <xsl:template match="node() | @*" mode="phase-3">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="phase-3"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Copies everything to the transformation output -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="phase-3"/>
        </xsl:copy>
    </xsl:template>
    
    
    <!-- Pretty Print -->
    <!--Makes sure everything is printed nicely-->
    <xsl:variable name="pretty-print-output">
        <xsl:apply-templates select="$phase-3-output" mode="pretty-print">
            <xsl:with-param name="tabs">
                <xsl:text></xsl:text>
            </xsl:with-param>
        </xsl:apply-templates>
    </xsl:variable>
    
    <!-- variable containing the amount of space for a tab -->
    <xsl:variable name="tab">
        <xsl:text>  </xsl:text>
    </xsl:variable>
    
    <!-- variable containing a new line -->
    <xsl:variable name="newline">
        <xsl:text>
</xsl:text>
    </xsl:variable>
    
    <!-- adds a new line and an appropriate amount of tabs before each comment -->
    <xsl:template match="*/comment()" mode="pretty-print">
        <xsl:param name="tabs" />
        <xsl:value-of select="$newline" />
        <xsl:value-of select="$tabs" />
        <xsl:comment><xsl:value-of select="."/></xsl:comment>
    </xsl:template>
    
    <!-- decides whether the children of the current node should be on a new
        line or not and calls the appropriate template-->
    <xsl:template match="*" mode="pretty-print">
        <xsl:param name="tabs" />
        <xsl:choose>
            
            <xsl:when test="local-name(.)='op' or local-name(.)='arg' or local-name(.)='slot'">
                <xsl:call-template name="no-new-line">
                    <xsl:with-param name="newlines">yes</xsl:with-param>
                    <xsl:with-param name="tabs">
                        <xsl:value-of select="$tabs" />
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            
            <xsl:otherwise>
                <xsl:call-template name="new-line">
                    <xsl:with-param name="tabs">
                        <xsl:value-of select="$tabs" />
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
            
        </xsl:choose>
    </xsl:template>
    
    <!-- formats a node that should have new lines before it's children -->
    <xsl:template name="new-line">
        <xsl:param name="tabs" />
        <xsl:value-of select="$newline" />
        <xsl:value-of select="$tabs" />
        <xsl:copy>
            <xsl:for-each select="@*">
                <xsl:call-template name="attribute-out" />
            </xsl:for-each>
            <xsl:choose>
                <xsl:when test="count(./*) = 0">
                    <xsl:value-of select="." />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="./node()" mode="pretty-print">
                        <xsl:with-param name="tabs">
                            <xsl:value-of select="$tabs" /><xsl:value-of select="$tab" />
                        </xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:value-of select="$newline" />
                    <xsl:value-of select="$tabs" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
    </xsl:template>
    
    <!-- formats a node with no new lines before it's children -->
    <xsl:template name="no-new-line">
        <xsl:param name="newlines" />
        <xsl:param name="tabs" />
        <xsl:if test="$newlines='yes'">
            <xsl:value-of select="$newline" />
            <xsl:value-of select="$tabs" />
        </xsl:if>
        <xsl:copy>
            <xsl:for-each select="@*">
                <xsl:call-template name="attribute-out" />
            </xsl:for-each>
            <xsl:choose>
                <xsl:when test="count(./*)=0">
                    <xsl:value-of select="." />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:for-each select="./node()">
                        <xsl:call-template name="no-new-line">
                            <xsl:with-param name="newlines">no</xsl:with-param>
                        </xsl:call-template>
                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
    </xsl:template>
    
    <!-- outputs an attribute -->
    <xsl:template name="attribute-out">
       <xsl:copy-of select="." />
    </xsl:template>
    
    <!-- Copies everything to the transformation output -->
    <xsl:template match="/">
        <xsl:copy-of select="$pretty-print-output"/>
    </xsl:template>
    
</xsl:stylesheet>