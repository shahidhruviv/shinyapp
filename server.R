##Sys.setlocale('LC_ALL','C')
library(shiny)
library(dplyr)
library(plotly)
library(rsconnect)

a<-read.csv("filename.csv", sep="," )
a<-subset(a, a$GrossWW>100000, rm.na=TRUE)
a<-mutate(a, "Return"=GrossWW/Budget)
a$Return<-round(a$Return, digits = 2)
a$Budget<-as.numeric(a$Budget)

shinyServer(function(input, output) {
  
    output$Plot <- renderPlotly({
        b<-subset(a, a[,1]>=input$year[1] & a[,1]<=input$year[2], rm.na=TRUE)
        c<-subset(b, b[,3]>=input$budget[1] & b[,3]<=input$budget[2], rm.na=TRUE)
        budget1<-input$budget[1]
        budget2<-input$budget[2]
        
        
        if(min(c$Budget)>=input$budget[1]){
            budget1<-min(c$Budget)
            }
        
        if(max(c$Budget)<=input$budget[2]){
            budget2<-max(c$Budget)
            }
        
        c<-subset(b, b[,3]>=budget1 & b[,3]<=budget2, rm.na=TRUE)
        mini<-length(c[,1])
         
        if(input$number<=length(c[,1])){mini<-input$number}
        
        
        if(input$bubble=="Return"){
            c<-c[order(-c$Return),]
            d<-subset(c[1:mini,], rm.na=TRUE)
            plot_ly(d, x = ~Budget, y = ~Return,text= ~paste(Name,"\n","Year:",Year,"\n","Gross:",GrossWW), type='scatter',
                mode='markers', marker=list(size=10, opacity=0.7))}
        else{
            c<-c[order(-c$GrossWW),]
            d<-subset(c[1:mini,], rm.na=TRUE)
            plot_ly(d, x = ~Budget, y = ~GrossWW,text= ~paste(Name,"\n","Year:",Year,"\n","Return:", Return), type='scatter',
                    mode='markers', marker=list(size=10,  opacity=0.7))
        }
   })
  
})
