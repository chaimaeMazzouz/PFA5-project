package com.pfa.servicedemandes.model;

public class EmailMessage{
    private String to;
    private String subject;
    private String content;

    public String getTo() {
        return to;
    }

    public String getSubject() {
        return subject;
    }

    public String getContent() {
        return content;
    }
    public EmailMessage(String to,String subject,String content){
        this.to=to;
        this.subject=subject;
        this.content=content;
    }

}