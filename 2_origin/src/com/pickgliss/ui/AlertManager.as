package com.pickgliss.ui
{
   import com.pickgliss.action.AlertAction;
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StringUtils;
   import flash.events.Event;
   
   public final class AlertManager
   {
      
      private static var _instance:AlertManager;
      
      public static var DEFAULT_CONFIRM_LABEL:String = "Đồng ý";
      
      public static const NOSELECTBTN:int = 0;
      
      public static const SELECTBTN:int = 1;
       
      
      private var _layerType:int;
      
      private var _simpleAlertInfo:AlertInfo;
      
      public function AlertManager()
      {
         super();
      }
      
      public static function get Instance() : AlertManager
      {
         if(_instance == null)
         {
            _instance = new AlertManager();
         }
         return _instance;
      }
      
      public function set layerType(param1:int) : void
      {
         _layerType = param1;
      }
      
      public function alert(param1:String, param2:AlertInfo, param3:int = 0, param4:String = null) : BaseAlerFrame
      {
         var _loc5_:BaseAlerFrame = ComponentFactory.Instance.creat(param1);
         _loc5_.addEventListener("propertiesChanged",__onAlertSizeChanged);
         _loc5_.addEventListener("removedFromStage",__onAlertRemoved);
         _loc5_.info = param2;
         if(param4 && CacheSysManager.isLock(param4))
         {
            CacheSysManager.getInstance().cache(param4,new AlertAction(_loc5_,_layerType,param3));
         }
         else
         {
            LayerManager.Instance.addToLayer(_loc5_,_layerType,_loc5_.info.frameCenter,param3);
            StageReferance.stage.focus = _loc5_;
         }
         return _loc5_;
      }
      
      private function __onAlertRemoved(param1:Event) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("propertiesChanged",__onAlertSizeChanged);
         _loc2_.removeEventListener("removedFromStage",__onAlertRemoved);
      }
      
      private function __onAlertSizeChanged(param1:ComponentEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         if(_loc2_.info.frameCenter)
         {
            _loc2_.x = (StageReferance.stageWidth - _loc2_.width) / 2;
            _loc2_.y = (StageReferance.stageHeight - _loc2_.height) / 2;
         }
      }
      
      public function setup(param1:int, param2:AlertInfo) : void
      {
         _simpleAlertInfo = param2;
         _layerType = param1;
      }
      
      public function simpleAlert(param1:String, param2:String, param3:String = "", param4:String = "", param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:int = 0, param9:String = null, param10:String = "SimpleAlert", param11:int = 30, param12:Boolean = true, param13:int = 0, param14:int = 0) : BaseAlerFrame
      {
         if(StringUtils.isEmpty(param3))
         {
            param3 = DEFAULT_CONFIRM_LABEL;
         }
         var _loc15_:AlertInfo = new AlertInfo();
         ObjectUtils.copyProperties(_loc15_,_simpleAlertInfo);
         _loc15_.sound = _simpleAlertInfo.sound;
         _loc15_.data = param2;
         _loc15_.autoDispose = param5;
         _loc15_.title = param1;
         _loc15_.submitLabel = param3;
         _loc15_.cancelLabel = param4;
         _loc15_.enableHtml = param6;
         _loc15_.mutiline = param7;
         _loc15_.buttonGape = param11;
         _loc15_.autoButtonGape = param12;
         _loc15_.type = param13;
         _loc15_.selectBtnY = param14;
         if(StringUtils.isEmpty(param4))
         {
            _loc15_.showCancel = false;
         }
         return alert(param10,_loc15_,param8,param9);
      }
   }
}
