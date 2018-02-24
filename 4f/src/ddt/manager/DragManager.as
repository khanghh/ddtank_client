package ddt.manager
{
   import bagAndInfo.cell.DragEffect;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.interfaces.IAcceptDrag;
   import ddt.interfaces.IDragable;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class DragManager extends EventDispatcher
   {
      
      public static const DRAG_IN_RANGE_TOP:String = "dragInRangeTop";
      
      public static const DRAG_IN_RANGE_BUTTOM:String = "dragOutRangeButtom";
      
      public static const DRAG_IN_HOT:String = "dragInHot";
      
      private static var _isDraging:Boolean;
      
      private static var _proxy:Sprite;
      
      private static var _dragEffect:DragEffect;
      
      private static var _source:IDragable;
      
      private static var _throughAll:Boolean;
      
      private static var _wheelFun:Function;
      
      private static var _passSelf:Boolean;
      
      private static var _isUpDrag:Boolean;
      
      private static var _changCardStateFun:Function;
      
      private static var _responseRectangle:DisplayObject;
      
      private static var _responseRange:int;
      
      private static var _isContinue:Boolean;
       
      
      public function DragManager(){super();}
      
      public static function get proxy() : Sprite{return null;}
      
      public static function get isDraging() : Boolean{return false;}
      
      public static function startDrag(param1:IDragable, param2:Object, param3:DisplayObject, param4:int, param5:int, param6:String = "none", param7:Boolean = true, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false, param11:Boolean = false, param12:DisplayObject = null, param13:int = 0, param14:Boolean = false) : Boolean{return false;}
      
      protected static function __checkResponse(param1:Event) : void{}
      
      public static function ListenWheelEvent(param1:Function) : void{}
      
      public static function removeListenWheelEvent() : void{}
      
      private static function __dispatchWheel(param1:MouseEvent) : void{}
      
      public static function changeCardState(param1:Function) : void{}
      
      private static function __stageMouseDown(param1:Event) : void{}
      
      private static function __removeFromStage(param1:Event) : void{}
      
      public static function __upDrag(param1:MouseEvent) : void{}
      
      private static function __stopDrag(param1:MouseEvent) : void{}
      
      public static function acceptDrag(param1:IAcceptDrag, param2:String = null) : void{}
   }
}
