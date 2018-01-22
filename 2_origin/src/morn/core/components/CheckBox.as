package morn.core.components
{
   public class CheckBox extends Button
   {
       
      
      public function CheckBox(param1:String = null, param2:String = "")
      {
         super(param1,param2);
      }
      
      override protected function preinitialize() : void
      {
         super.preinitialize();
         _toggle = true;
         _autoSize = false;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         _btnLabel.autoSize = "left";
      }
      
      override protected function changeLabelSize() : void
      {
         exeCallLater(changeClips);
         _btnLabel.x = _bitmap.width + _labelMargin[0];
         _btnLabel.y = (_bitmap.height - _btnLabel.height) * 0.5 + _labelMargin[1];
      }
      
      override public function commitMeasure() : void
      {
         exeCallLater(this.changeLabelSize);
      }
      
      override public function set dataSource(param1:Object) : void
      {
         _dataSource = param1;
         if(param1 is Boolean)
         {
            selected = param1;
         }
         else if(param1 is String)
         {
            selected = param1 == "true";
         }
         else
         {
            super.dataSource = param1;
         }
      }
   }
}
