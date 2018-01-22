package com.pickgliss.action
{
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import flash.display.DisplayObject;
   
   public class ShowTipAction extends BaseAction
   {
       
      
      private var _tip:DisplayObject;
      
      private var _sound:String;
      
      public function ShowTipAction(param1:DisplayObject, param2:String = null)
      {
         super();
         _tip = param1;
         _sound = param2;
      }
      
      override public function act() : void
      {
         if(_sound && ComponentSetting.PLAY_SOUND_FUNC is Function)
         {
            ComponentSetting.PLAY_SOUND_FUNC(_sound);
         }
         LayerManager.Instance.addToLayer(_tip,2,false,0,false);
      }
   }
}
