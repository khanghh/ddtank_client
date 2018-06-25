package com.pickgliss.action
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   
   public class AlertAction extends BaseAction
   {
       
      
      private var _alert:BaseAlerFrame;
      
      private var _layerType:int;
      
      private var _blockBackgound:int;
      
      private var _soundStr:String;
      
      private var _center:Boolean;
      
      public function AlertAction(alert:BaseAlerFrame, layerType:int, blockBackgound:int, soundStr:String = null, center:Boolean = true)
      {
         super();
         _alert = alert;
         _layerType = layerType;
         _blockBackgound = blockBackgound;
         _soundStr = soundStr;
         _center = center;
      }
      
      override public function act() : void
      {
         if(_soundStr && ComponentSetting.PLAY_SOUND_FUNC is Function)
         {
            ComponentSetting.PLAY_SOUND_FUNC(_soundStr);
         }
         if(_alert && _alert.info)
         {
            LayerManager.Instance.addToLayer(_alert,_layerType,_alert.info.frameCenter,_blockBackgound);
            StageReferance.stage.focus = _alert;
         }
      }
   }
}
