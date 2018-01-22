package gameCommon.view.prop
{
   import bagAndInfo.cell.DragEffect;
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.PropInfo;
   import ddt.interfaces.IAcceptDrag;
   import ddt.interfaces.IDragable;
   import ddt.manager.BitmapManager;
   import ddt.manager.DragManager;
   import ddt.manager.SharedManager;
   import ddt.view.tips.ToolPropInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import org.aswing.KeyboardManager;
   
   public class PropCell extends Sprite implements Disposeable, ITipedDisplay, IDragable, IAcceptDrag
   {
       
      
      protected var _x:int;
      
      protected var _y:int;
      
      protected var _enabled:Boolean = true;
      
      protected var _info:PropInfo;
      
      protected var _asset:DisplayObject;
      
      protected var _isExist:Boolean;
      
      protected var _back:DisplayObject;
      
      protected var _fore:DisplayObject;
      
      protected var _shortcutKey:String;
      
      protected var _shortcutKeyShape:DisplayObject;
      
      protected var _tipInfo:ToolPropInfo;
      
      protected var _tweenMax:TweenLite;
      
      protected var _localVisible:Boolean = true;
      
      protected var _mode:int;
      
      protected var _bitmapMgr:BitmapManager;
      
      private var _allowDrag:Boolean;
      
      protected var _grayFilters:Array;
      
      private var _isUsed:Boolean;
      
      public function PropCell(param1:String = null, param2:int = -1, param3:Boolean = false){super();}
      
      public function get shortcutKey() : String{return null;}
      
      public function get isUsed() : Boolean{return false;}
      
      public function set isUsed(param1:Boolean) : void{}
      
      public function dragStart() : void{}
      
      public function setGrayFilter() : void{}
      
      public function dragStop(param1:DragEffect) : void{}
      
      public function dragDrop(param1:DragEffect) : void{}
      
      public function getSource() : IDragable{return null;}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function get tipData() : Object{return null;}
      
      public function set tipData(param1:Object) : void{}
      
      public function get tipDirctions() : String{return null;}
      
      public function set tipDirctions(param1:String) : void{}
      
      public function get tipGapH() : int{return 0;}
      
      public function set tipGapH(param1:int) : void{}
      
      public function get tipGapV() : int{return 0;}
      
      public function set tipGapV(param1:int) : void{}
      
      public function get tipStyle() : String{return null;}
      
      public function set tipStyle(param1:String) : void{}
      
      protected function configUI() : void{}
      
      protected function drawLayer() : void{}
      
      protected function addEvent() : void{}
      
      protected function __mouseOut(param1:MouseEvent) : void{}
      
      protected function __mouseOver(param1:MouseEvent) : void{}
      
      protected function removeEvent() : void{}
      
      public function get info() : PropInfo{return null;}
      
      public function setMode(param1:int) : void{}
      
      public function set info(param1:PropInfo) : void{}
      
      public function get enabled() : Boolean{return false;}
      
      public function set enabled(param1:Boolean) : void{}
      
      public function get isExist() : Boolean{return false;}
      
      public function set isExist(param1:Boolean) : void{}
      
      public function setPossiton(param1:int, param2:int) : void{}
      
      public function dispose() : void{}
      
      public function useProp() : void{}
      
      public function get localVisible() : Boolean{return false;}
      
      public function setVisible(param1:Boolean) : void{}
      
      public function set back(param1:DisplayObject) : void{}
   }
}
