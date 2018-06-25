package yzhkof.ui
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class TextPanel extends BackGroudContainer
   {
       
      
      private var textfield:TextField;
      
      public function TextPanel(color:uint = 16777215)
      {
         this.textfield = new TextField();
         super(color);
         addChild(this.textfield);
         this.textfield.autoSize = TextFieldAutoSize.LEFT;
         this.textfield.selectable = false;
         this.textfield.mouseEnabled = false;
         buttonMode = true;
      }
      
      public function set text(value:String) : void
      {
         if(this.text == value)
         {
            return;
         }
         this.textfield.text = value || "";
         commitChage("text");
      }
      
      public function get text() : String
      {
         return this.textfield.text;
      }
   }
}
