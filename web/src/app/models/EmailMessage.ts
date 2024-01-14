export class EmailMessage {
    to: string;
    subjet: string;
    content: string;
  
    constructor(
      to: string = '',
      subjet: string = '',
      content: string = 'Your request has been evaluated !',
    ) {
      this.to = to;
      this.subjet = subjet;
      this.content = content;
    }
  }
  