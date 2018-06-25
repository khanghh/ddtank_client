package com.pickgliss.action
{
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import flash.display.DisplayObject;
   
   public class ShowTipAction extends BaseAction
   {
       
      
      private var _tip:DisplayObject;
      
      private var _sound:String;
      
      public function ShowTipAction(tip:DisplayObject, sound:String = null)
      {
         super();
         _tip = tip;
         _sound = sound;
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
