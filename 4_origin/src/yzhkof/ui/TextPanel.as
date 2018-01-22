package yzhkof.ui
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class TextPanel extends BackGroudContainer
   {
       
      
      private var textfield:TextField;
      
      public function TextPanel(param1:uint = 16777215)
      {
         this.textfield = new TextField();
         super(param1);
         addChild(this.textfield);
         this.textfield.autoSize = TextFieldAutoSize.LEFT;
         this.textfield.selectable = false;
         this.textfield.mouseEnabled = false;
         buttonMode = true;
      }
      
      public function set text(param1:String) : void
      {
         if(this.text == param1)
         {
            return;
         }
         this.textfield.text = param1 || "";
         commitChage("text");
      }
      
      public function get text() : String
      {
         return this.textfield.text;
      }
   }
}
