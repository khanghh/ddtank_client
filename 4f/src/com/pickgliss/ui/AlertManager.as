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
      
      public function AlertManager(){super();}
      
      public static function get Instance() : AlertManager{return null;}
      
      public function set layerType(param1:int) : void{}
      
      public function alert(param1:String, param2:AlertInfo, param3:int = 0, param4:String = null) : BaseAlerFrame{return null;}
      
      private function __onAlertRemoved(param1:Event) : void{}
      
      private function __onAlertSizeChanged(param1:ComponentEvent) : void{}
      
      public function setup(param1:int, param2:AlertInfo) : void{}
      
      public function simpleAlert(param1:String, param2:String, param3:String = "", param4:String = "", param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:int = 0, param9:String = null, param10:String = "SimpleAlert", param11:int = 30, param12:Boolean = true, param13:int = 0, param14:int = 0) : BaseAlerFrame{return null;}
   }
}
