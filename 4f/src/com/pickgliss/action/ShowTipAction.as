package com.pickgliss.action
{
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import flash.display.DisplayObject;
   
   public class ShowTipAction extends BaseAction
   {
       
      
      private var _tip:DisplayObject;
      
      private var _sound:String;
      
      public function ShowTipAction(param1:DisplayObject, param2:String = null){super();}
      
      override public function act() : void{}
   }
}
