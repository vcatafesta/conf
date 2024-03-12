<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
   <xsl:template match="/">
      <html>
         <body>
            <table border="1">
               <xsl:for-each select="list/*">
                  <xsl:sort select="text()" />
                  <tr>
                     <td>
                        <xsl:value-of select="text()" />
                     </td>
                     <td>
                        <xsl:value-of select="@mtime" />
                     </td>
                     <td>
                        <xsl:value-of select="@size" />
                     </td>
                  </tr>
               </xsl:for-each>
            </table>
         </body>
      </html>
   </xsl:template>
</xsl:stylesheet>

