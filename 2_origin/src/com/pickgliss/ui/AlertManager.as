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
      
      public function set layerType(value:int) : void
      {
         _layerType = value;
      }
      
      public function alert(frameStyle:String, info:AlertInfo, blockBackgound:int = 0, cacheFlag:String = null) : BaseAlerFrame
      {
         var alert:BaseAlerFrame = ComponentFactory.Instance.creat(frameStyle);
         alert.addEventListener("propertiesChanged",__onAlertSizeChanged);
         alert.addEventListener("removedFromStage",__onAlertRemoved);
         alert.info = info;
         if(cacheFlag && CacheSysManager.isLock(cacheFlag))
         {
            CacheSysManager.getInstance().cache(cacheFlag,new AlertAction(alert,_layerType,blockBackgound));
         }
         else
         {
            LayerManager.Instance.addToLayer(alert,_layerType,alert.info.frameCenter,blockBackgound);
            StageReferance.stage.focus = alert;
         }
         return alert;
      }
      
      private function __onAlertRemoved(event:Event) : void
      {
         var alert:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         alert.removeEventListener("propertiesChanged",__onAlertSizeChanged);
         alert.removeEventListener("removedFromStage",__onAlertRemoved);
      }
      
      private function __onAlertSizeChanged(event:ComponentEvent) : void
      {
         var alert:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         if(alert.info.frameCenter)
         {
            alert.x = (StageReferance.stageWidth - alert.width) / 2;
            alert.y = (StageReferance.stageHeight - alert.height) / 2;
         }
      }
      
      public function setup(layerType:int, simpleAlertInfo:AlertInfo) : void
      {
         _simpleAlertInfo = simpleAlertInfo;
         _layerType = layerType;
      }
      
      public function simpleAlert(title:String, msg:String, submitLabel:String = "", cancelLabel:String = "", autoDispose:Boolean = false, enableHtml:Boolean = false, multiLine:Boolean = false, blockBackgound:int = 0, cacheFlag:String = null, frameStyle:String = "SimpleAlert", buttonGape:int = 30, autoButtonGape:Boolean = true, type:int = 0, selectBtnY:int = 0) : BaseAlerFrame
      {
         if(StringUtils.isEmpty(submitLabel))
         {
            submitLabel = DEFAULT_CONFIRM_LABEL;
         }
         var alerInfo:AlertInfo = new AlertInfo();
         ObjectUtils.copyProperties(alerInfo,_simpleAlertInfo);
         alerInfo.sound = _simpleAlertInfo.sound;
         alerInfo.data = msg;
         alerInfo.autoDispose = autoDispose;
         alerInfo.title = title;
         alerInfo.submitLabel = submitLabel;
         alerInfo.cancelLabel = cancelLabel;
         alerInfo.enableHtml = enableHtml;
         alerInfo.mutiline = multiLine;
         alerInfo.buttonGape = buttonGape;
         alerInfo.autoButtonGape = autoButtonGape;
         alerInfo.type = type;
         alerInfo.selectBtnY = selectBtnY;
         if(StringUtils.isEmpty(cancelLabel))
         {
            alerInfo.showCancel = false;
         }
         return alert(frameStyle,alerInfo,blockBackgound,cacheFlag);
      }
   }
}
