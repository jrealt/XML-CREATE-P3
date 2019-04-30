<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="text" encoding="UTF-8" indent="no"/>
	<xsl:template match="/">
		\documentclass[12pt]{article}
		\usepackage[utf8]{inputenc}
		\usepackage{graphicx}
		\usepackage{hyperref}
		\hypersetup{colorlinks=true,linktoc=all,linkcolor=black}
		\newcommand{\imagen}[3]{
			\begin{center}
				\includegraphics[width=\linewidth]{#1}
				#2#3
			\end{center}
		}
		\begin{document}
		\begin{titlepage}
			\raggedleft
			\rule{1pt}{\textheight}
			\hspace{0.05\textwidth}
			\parbox[b]{0.75\textwidth}{
				{\Huge\bfseries Learning XML.}\\
				{\LARGE \bfseries Un portal web para aprender XML en múltiples formatos.}\\[2\baselineskip]
				{\large\textit{Producto 3}}\\
				{\large\textit{Otros formatos, \LaTeX}}\\[4\baselineskip]
				{\Large\textsc{Grupo Create}}
				\vspace{0.5\textheight}
			}
		\end{titlepage}
		\pagenumbering{gobble}
		\newpage
		\renewcommand{\contentsname}{Índice}
		\tableofcontents
		\newpage
		\pagenumbering{arabic}
		<xsl:for-each select="contenido/tema">
		    \section{<xsl:value-of select="./@titulo" />}
		    <xsl:if test = "texto">
		        <xsl:for-each select="texto">
		            <xsl:apply-templates />
		        </xsl:for-each>
		    </xsl:if>
		    <xsl:if test = "subtema">
		        <xsl:for-each select="subtema">
		            \subsection{<xsl:value-of select="./@titulo" />}
		            <xsl:if test = "texto">
		                <xsl:for-each select="texto">
		                    <xsl:apply-templates />
		                </xsl:for-each>
		            </xsl:if>
		            <xsl:if test = "subsubtema">
		                <xsl:for-each select="subsubtema">
		                    \subsubsection{<xsl:value-of select="./@titulo" />}
		                    <xsl:if test = "texto">
		                        <xsl:for-each select="texto">
		                            <xsl:apply-templates />
		                        </xsl:for-each>
		                    </xsl:if>
		                </xsl:for-each>
		            </xsl:if>
		        </xsl:for-each>
		    </xsl:if>
		</xsl:for-each>
		\end{document}
	</xsl:template>
	<xsl:template match="text()">
    	<xsl:value-of select= "translate(.,'&amp;','')"/>
	</xsl:template>
	<xsl:template match="negrita">\textbf{<xsl:apply-templates />}</xsl:template>
	
	<xsl:template match="cursiva">\textit{<xsl:apply-templates />}</xsl:template>
	
	<xsl:template match="frase"><xsl:apply-templates /></xsl:template>
	
	<xsl:template match="parrafo">\par <xsl:apply-templates />
	</xsl:template>
	
	<xsl:template match="web">
		<xsl:variable name="enlace"><xsl:value-of select="./@enlace" /></xsl:variable>
		\href{<xsl:value-of select="$enlace"/>}{<xsl:apply-templates />}
	</xsl:template>
	
	<xsl:template match="elemento">
		\item <xsl:apply-templates /></xsl:template>
	
	<xsl:template match="lista_desordenada">
		\begin{itemize}
			<xsl:apply-templates />
		\end{itemize}
	</xsl:template>
	
	<xsl:template match="lista_ordenada">
		\begin{enumerate}
			<xsl:apply-templates />
		\end{enumerate}
	</xsl:template>
	
	<xsl:template match="imagen">
		<xsl:variable name="enlace"><xsl:value-of select="./@enlace" /></xsl:variable>
		<xsl:variable name="descripcion"><xsl:value-of select="." /></xsl:variable>
		\imagen{<xsl:value-of select="$enlace"/>}{<xsl:value-of select="$descripcion"/>}{}
		
	</xsl:template>
	
	<xsl:template match="cabecera">
		<xsl:apply-templates />
	</xsl:template>
	
	<xsl:template match="columna">
		<xsl:apply-templates />
	</xsl:template>
	
	<xsl:template match="fila">
		
		<xsl:if test = "cabecera">
			<xsl:variable name="maxindex" select="count(cabecera)"/>
			<xsl:for-each select="cabecera">
		    <xsl:choose>
		    	<xsl:when test = "position() = $maxindex">
		    		<xsl:apply-templates />\\
		    	</xsl:when>
		      
		    	<xsl:otherwise>
		    		<xsl:apply-templates /> &amp;
		    	</xsl:otherwise>
		    </xsl:choose>
		    </xsl:for-each>
		</xsl:if>
		<xsl:if test = "columna">
			<xsl:variable name="maxindex" select="count(columna)"/>
			<xsl:for-each select="columna">
		    <xsl:choose>
		    	<xsl:when test = "position() = $maxindex">
		    		<xsl:apply-templates />\\
		    	</xsl:when>
		      
		    	<xsl:otherwise>
		    		<xsl:apply-templates /> &amp;
		    	</xsl:otherwise>
		    </xsl:choose>
		    </xsl:for-each>
		</xsl:if>
		\hline
	</xsl:template>
	
	<xsl:template match="tabla">
		<xsl:variable name="maxindex" select="count(./fila[1]/cabecera)"/>
		\begin{table}
		  \begin{center}
		    \begin{tabular}{|<xsl:for-each select="./fila[1]/cabecera">p{4.1cm}|</xsl:for-each>}
		    \hline
		    <xsl:apply-templates />
		    \end{tabular}
		  \end{center}
		\end{table}
	</xsl:template>
	
</xsl:stylesheet>