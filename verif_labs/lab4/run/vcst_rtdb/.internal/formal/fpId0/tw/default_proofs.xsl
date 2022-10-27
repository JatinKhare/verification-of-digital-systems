<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
    <html>
    <head>
    <style>
    #mytable_green {
      font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
      border-collapse: collapse;
      width: 100%;
    }

    #mytable_green td, #mytable_green th {
      border: 1px solid #ddd;
      padding: 8px;
    }

    #mytable_green tr:nth-child(even){background-color: #f2f2f2;}

    #mytable_green tr:hover {background-color: #ddd;}

    #mytable_green th {
      padding-top: 12px;
      padding-bottom: 12px;
      text-align: left;
      background-color: #4CAF50;
      color: white;
    }
    
    #mytable_red {
      font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
      border-collapse: collapse;
      width: 100%;
    }

    #mytable_red td, #mytable_red th {
      border: 1px solid #ddd;
      padding: 8px;
    }

    #mytable_red tr:nth-child(even){background-color: #f2f2f2;}

    #mytable_red tr:hover {background-color: #ddd;}

    #mytable_red th {
      padding-top: 12px;
      padding-bottom: 12px;
      text-align: left;
      background-color: #FFD700;
      color: black;
    }
    </style>
    </head>
    <body style="font-family:Arial;font-size:12pt;background-color:#EEEEEE">

    <xsl:for-each select="ProofReport/v1/ProofManager/topProofs">
       <div style="background-color:teal;color:white;padding:4px">
           <span style="font-weight:bold">Proof Summary</span>
       </div>
       <br />
       <table id="mytable_green">
         <tr>        
            <th>Name</th>
            <th>Type</th>
            <th>#Goals</th>
            <th>#Success</th>
            <th>#Failed</th>
            <th>#Inconcl</th>
            <th>% Converged</th>
        </tr>
       <xsl:call-template name="summaryProof">
          <xsl:with-param name="records" select="ProofNode"/>
          <xsl:with-param name="ptype" select="'-1'"/>
          <xsl:with-param name="indent" select="'0'"/>
       </xsl:call-template>
       </table>
       
       <br />
       <div style="background-color:teal;color:white;padding:4px">
           <span style="font-weight:bold">Proof List</span>
       </div>
       <xsl:call-template name="listProof">
          <xsl:with-param name="records" select="ProofNode"/>
          <xsl:with-param name="ptype" select="'-1'"/>
       </xsl:call-template>
    </xsl:for-each>
    
    <xsl:for-each select="Tasks">
       <xsl:call-template name="listTask">
          <xsl:with-param name="records" select="Task"/>
       </xsl:call-template>
    </xsl:for-each>

    </body>
    </html>
    </xsl:template>

    <xsl:template name="listTask">
	<xsl:param name="records"/>
        <table id="mytable_green">
        <tr>        
            <th>Id</th>
            <th>Status</th>
            <th>Result</th>
            <th>Machine</th>
            <th>Proof</th>
            <th>Goal</th>
            <th>Time</th>
            <th>Mem</th>
            <th>Engine</th>
        </tr>

        <xsl:for-each select="$records">
            <tr>
                <td><xsl:value-of select="Id"/></td>
                <td><xsl:value-of select="Status"/></td>
                <xsl:call-template name="printTaskResult">
	           <xsl:with-param name="data" select="Result"/>
	        </xsl:call-template>
                <td><xsl:value-of select="Machine"/></td>
                <td><xsl:value-of select="Proof"/></td>
                <td><xsl:value-of select="Goal"/></td>
                <td><xsl:value-of select="Time"/></td>
                <td><xsl:value-of select="Mem"/></td>
                <td><xsl:value-of select="Type"/></td>
            </tr>
        </xsl:for-each>
        </table>
    </xsl:template>

    <xsl:template name="listProof">
	<xsl:param name="records"/>
	<xsl:param name="ptype"/>
       
        <xsl:for-each select="$records">
            <xsl:variable name="numGoals" select="Summary/Total"/> 
            <xsl:variable name="type" select="Type"/> 
            <xsl:variable name="name" select="Name"/> 
            <xsl:variable name="converged" select="Summary/Success + Summary/Failed"/> 
           
            <!-- Used for href -->   
            <div id="{$name}" />
	    <script type="text/javascript">
                <xsl:value-of select="concat('replaceAll(',$name,');')"/>
            </script>
            <xsl:if test="$numGoals &gt; 0">
            <br />
            <table id="mytable_green">
            <tr>        
                <th>Name</th>
                <th>Type</th>
                <th>#Goals</th>
                <th>#Success</th>
                <th>#Failed</th>
                <th>#Inconcl</th>
                <th>% Converged</th>
            </tr>
            <tr>
                <td><xsl:value-of select="Name"/></td>
                <xsl:call-template name="printType">
	           <xsl:with-param name="data" select="$ptype"/>
	        </xsl:call-template>
                <td><xsl:value-of select="$numGoals"/></td>
                <td><xsl:value-of select="Summary/Success"/></td>
                <td><xsl:value-of select="Summary/Failed"/></td>
                <td><xsl:value-of select="(Summary/Inconcl + Summary/Conflict + Summary/ConflictInconcl)"/></td>
                <td><xsl:value-of select="floor(($converged div $numGoals) * 100)"/></td>
            </tr>
            </table>
         
            <br />
            <table id="mytable_red">
            <tr>        
                <th>GoalId</th>
                <th>Status</th>
                <th>Solved Depth</th>
                <th>CEX Depth</th>
                <th>BE_Name</th>
                <th>BE_Time</th>
                <th>BE_ETime</th>
                <th>BE_Memory</th>
                <th>BE_Tag</th>
                <th>Name</th>
            </tr>       
            <xsl:call-template name="listGoal">
	        <xsl:with-param name="records" select="Goals/GCStats"/>
	    </xsl:call-template>
            </table>
            
            </xsl:if> 

            <xsl:for-each select="ChildProofs">
               <xsl:call-template name="listProof">
                  <xsl:with-param name="records" select="ProofNode"/>
                  <xsl:with-param name="ptype" select="$type"/>
               </xsl:call-template>
            </xsl:for-each>

	</xsl:for-each>
    </xsl:template>

    <xsl:template name="listGoal">
        <xsl:param name="records"/>
	              
        <xsl:for-each select="$records">
            <tr>
                <td><xsl:value-of select="GoalId"/></td>
                <xsl:call-template name="printStatus">
	           <xsl:with-param name="data" select="Status"/>
	        </xsl:call-template>
                <xsl:call-template name="printPositive">
	           <xsl:with-param name="data" select="SolvedDepth"/>
	        </xsl:call-template>
                <xsl:call-template name="printPositive">
	           <xsl:with-param name="data" select="CexDepth"/>
	        </xsl:call-template>
                <xsl:call-template name="printBestEngine">
                    <xsl:with-param name="records" select="Engines/EngineStats"/>
	           <xsl:with-param name="bestengineid" select="BestEngineId"/>
                </xsl:call-template>
                <xsl:call-template name="printName" />
            </tr>
	</xsl:for-each>
    </xsl:template>

    <xsl:template name="printBestEngine">
	<xsl:param name="records"/>
	<xsl:param name="bestengineid"/>

        <xsl:choose>
                <xsl:when test="$bestengineid &gt; 0">
                <xsl:for-each select="$records">
                    <xsl:if test="Id = $bestengineid">
                        <td><xsl:value-of select="Name"/></td>
                        <td><xsl:value-of select="Time"/></td>
                        <td><xsl:value-of select='format-number(ETime, "#.00")'/></td>
                        <td><xsl:value-of select="Memory"/></td>
                        <td><xsl:value-of select="Tag"/></td>
                    </xsl:if> 
                </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <td>-</td>
                    <td>-</td>
                    <td>-</td>
                    <td>-</td>
                    <td>-</td>
                </xsl:otherwise>
            </xsl:choose>

    </xsl:template>

    <xsl:template name="summaryProof">
	<xsl:param name="records"/>
	<xsl:param name="ptype"/>
	<xsl:param name="indent"/>
       
        <xsl:for-each select="$records">
            <xsl:variable name="numGoals" select="Summary/Total"/> 
            <xsl:variable name="type" select="Type"/> 
            <xsl:variable name="converged" select="Summary/Success + Summary/Failed"/> 
            <xsl:variable name="ahrefname" select="concat('#',Name)"/> 
           
	    <xsl:if test="$numGoals &gt; 0">
            <tr>
                <td>
                    <xsl:call-template name="printIndent">
	                <xsl:with-param name="data" select="$indent"/>
	            </xsl:call-template>
                    <a href="{$ahrefname}">
	                <script type="text/javascript">
                            <xsl:value-of
                            select="concat('replaceAll(',$ahrefname,');')"/>
                        </script>
                    <xsl:value-of select="Name"/>
                    </a>
                </td>
                <xsl:call-template name="printType">
	           <xsl:with-param name="data" select="$ptype"/>
	        </xsl:call-template>
                <td><xsl:value-of select="$numGoals"/></td>
                <td><xsl:value-of select="Summary/Success"/></td>
                <td><xsl:value-of select="Summary/Failed"/></td>
                <td><xsl:value-of select="(Summary/Inconcl + Summary/Conflict + Summary/ConflictInconcl)"/></td>
                <td><xsl:value-of select="floor(($converged div $numGoals) * 100)"/></td>
            </tr>
            </xsl:if> 

            <xsl:for-each select="ChildProofs">
               <xsl:call-template name="summaryProof">
                  <xsl:with-param name="records" select="ProofNode"/>
                  <xsl:with-param name="ptype" select="$type"/>
                  <xsl:with-param name="indent" select="$indent + 2"/>
               </xsl:call-template>
            </xsl:for-each>
	</xsl:for-each>
    </xsl:template>

    <xsl:template name="printTaskResult">
	<xsl:param name="data"/>
        <xsl:choose>
            <xsl:when test="($data = 'memory_limit') 
            or ($data = 'signal_killed_cntrl')
            or ($data = 'signal_killed_worker')
            or ($data = 'worker_crash')
            or ($data = 'worker_start_failure')
            or ($data = 'wc_error')
            ">
                <td bgcolor="#FFB9BB"><xsl:value-of select="$data"/></td>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="($data = 'success')"> 
                        <td bgcolor="#D0F0C0">normal</td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td bgcolor="#D0F0C0"><xsl:value-of select="$data"/></td>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="printStatus">
	<xsl:param name="data"/>
	<xsl:if test="$data = 0">
           <td bgcolor="#FFB9BB">failed</td>
        </xsl:if> 
	<xsl:if test="$data = 1">
           <td bgcolor="#D0F0C0">success</td>
        </xsl:if> 
	<xsl:if test="$data = 2">
           <td bgcolor="#FCF4A3">inconcl</td>
        </xsl:if> 
    </xsl:template>

    <xsl:template name="printType">
	<xsl:param name="data"/>
	<xsl:if test="$data = -1">
           <td>root</td>
        </xsl:if> 
	<xsl:if test="$data = 5">
           <td>abs</td>
        </xsl:if> 
	<xsl:if test="$data = 3">
           <td>or</td>
        </xsl:if> 
	<xsl:if test="$data = 2">
           <td>dcp</td>
        </xsl:if> 
	<xsl:if test="$data != 2 and $data != 3 and $data != 5 and $data != -1">
           <td><xsl:value-of select="$data"/></td>
        </xsl:if> 
    </xsl:template>

    <xsl:template name="printPositive">
	<xsl:param name="data"/>
        <xsl:variable name="posval"> 
            <xsl:choose>
                <xsl:when test="$data &gt; 0">
                    <xsl:value-of select="$data"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'-'"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable> 
        <td><xsl:value-of select="$posval"/></td>
    </xsl:template>

    <xsl:template name="printName">
        <xsl:variable name="name"> 
            <xsl:choose>
            <xsl:when test="Name != ''">
                <xsl:value-of select="Name"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                <xsl:when test="Expr != ''">
                    <xsl:value-of select="Expr"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                    <xsl:when test="Handle != ''">
                        <xsl:value-of select="Handle"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="'-'"/>
                    </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
            </xsl:choose>
        </xsl:variable> 
        <td><xsl:value-of select="$name"/></td>
    </xsl:template>

    <xsl:template name="printIndent">
	<xsl:param name="data"/>
	<xsl:if test="$data &gt; 0">
            &#160;
            <xsl:call-template name="printIndent">
               <xsl:with-param name="data" select="$data - 1"/>
            </xsl:call-template>
        </xsl:if> 
    </xsl:template>
    
</xsl:stylesheet>
