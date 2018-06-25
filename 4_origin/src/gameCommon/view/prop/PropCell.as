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
      
      public function PropCell(shortcutKey:String = null, mode:int = -1, allowDrag:Boolean = false)
      {
         super();
         _bitmapMgr = BitmapManager.getBitmapMgr("GameView");
         _shortcutKey = shortcutKey;
         _grayFilters = ComponentFactory.Instance.creatFilters("grayFilter");
         _mode = mode;
         mouseChildren = false;
         _allowDrag = allowDrag;
         configUI();
         addEvent();
      }
      
      public function get shortcutKey() : String
      {
         return _shortcutKey;
      }
      
      public function get isUsed() : Boolean
      {
         return _isUsed;
      }
      
      public function set isUsed(value:Boolean) : void
      {
         _isUsed = value;
      }
      
      public function dragStart() : void
      {
         if(_info && _allowDrag)
         {
            if(_enabled)
            {
               DragManager.startDrag(this,_info,_asset,stage.mouseX,stage.mouseY,"none",false,true,false,false,true);
            }
            else
            {
               _asset.filters = _grayFilters;
               DragManager.startDrag(this,_info,_asset,stage.mouseX,stage.mouseY,"none",false,true,false,false,true);
            }
         }
      }
      
      public function setGrayFilter() : void
      {
         filters = _grayFilters;
      }
      
      public function dragStop(effect:DragEffect) : void
      {
         KeyboardManager.getInstance().isStopDispatching = false;
         if(effect.target == null || effect.target is PropCell == false)
         {
            info = _info;
         }
         var cell:PropCell = effect.target as PropCell;
         var tempInfo:PropInfo = cell.info;
         var tempEnabled:Boolean = cell._enabled;
         var tempId:int = SharedManager.Instance.GameKeySets[cell.shortcutKey];
         cell.info = info;
         SharedManager.Instance.GameKeySets[cell.shortcutKey] = SharedManager.Instance.GameKeySets[this.shortcutKey];
         info = tempInfo;
         SharedManager.Instance.GameKeySets[this.shortcutKey] = tempId;
         SharedManager.Instance.save();
         cell.enabled = enabled;
         this.enabled = tempEnabled;
      }
      
      public function dragDrop(effect:DragEffect) : void
      {
         if(_allowDrag)
         {
            effect.action = "none";
            DragManager.acceptDrag(this);
         }
      }
      
      public function getSource() : IDragable
      {
         return this;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function get tipData() : Object
      {
         return _tipInfo;
      }
      
      public function set tipData(value:Object) : void
      {
      }
      
      public function get tipDirctions() : String
      {
         return "5,2,7,1,6,4";
      }
      
      public function set tipDirctions(value:String) : void
      {
      }
      
      public function get tipGapH() : int
      {
         return 20;
      }
      
      public function set tipGapH(value:int) : void
      {
      }
      
      public function get tipGapV() : int
      {
         return 20;
      }
      
      public function set tipGapV(value:int) : void
      {
      }
      
      public function get tipStyle() : String
      {
         return "core.ToolPropTips";
      }
      
      public function set tipStyle(value:String) : void
      {
      }
      
      protected function configUI() : void
      {
         _back = _bitmapMgr.creatBitmapShape("asset.game.prop.ItemBack",null,false,true);
         addChild(_back);
         _fore = _bitmapMgr.creatBitmapShape("asset.game.prop.ItemFore",null,false,true);
         var _loc1_:int = 2;
         _fore.y = _loc1_;
         _fore.x = _loc1_;
         addChild(_fore);
         if(_shortcutKey != null)
         {
            _shortcutKeyShape = ComponentFactory.Instance.creatBitmap("asset.game.prop.ShortcutKey" + _shortcutKey);
            Bitmap(_shortcutKeyShape).smoothing = true;
            _shortcutKeyShape.y = -2;
            addChild(_shortcutKeyShape);
         }
         _tipInfo = new ToolPropInfo();
         _tipInfo.showThew = true;
         drawLayer();
      }
      
      protected function drawLayer() : void
      {
         if(_shortcutKey == null)
         {
            return;
         }
         if(_mode == 2)
         {
            _shortcutKeyShape.x = 36 - _shortcutKeyShape.width;
         }
         else
         {
            _shortcutKeyShape.x = 0;
         }
      }
      
      protected function addEvent() : void
      {
         addEventListener("mouseOver",__mouseOver);
         addEventListener("mouseOut",__mouseOut);
      }
      
      protected function __mouseOut(event:MouseEvent) : void
      {
         x = _x;
         y = _y;
         scaleY = 1;
         scaleX = 1;
         if(_shortcutKey != null)
         {
            var _loc2_:int = 1;
            _shortcutKeyShape.scaleY = _loc2_;
            _shortcutKeyShape.scaleX = _loc2_;
         }
         if(_tweenMax)
         {
            _tweenMax.pause();
         }
         if(_enabled)
         {
            filters = null;
         }
         else
         {
            filters = _grayFilters;
         }
      }
      
      protected function __mouseOver(event:MouseEvent) : void
      {
         if(_info != null)
         {
            if(_shortcutKey != null)
            {
               var _loc2_:* = 0.9;
               _shortcutKeyShape.scaleY = _loc2_;
               _shortcutKeyShape.scaleX = _loc2_;
            }
            x = _x - 3.6;
            y = _y - 3.6;
            scaleY = 1.2;
            scaleX = 1.2;
            if(enabled)
            {
               if(_tweenMax == null)
               {
                  _tweenMax = TweenMax.to(this,0.5,{
                     "repeat":-1,
                     "yoyo":true,
                     "glowFilter":{
                        "color":16777011,
                        "alpha":1,
                        "blurX":4,
                        "blurY":4,
                        "strength":3
                     }
                  });
               }
               _tweenMax.play();
            }
            if(parent)
            {
               parent.setChildIndex(this,parent.numChildren - 1);
            }
         }
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("mouseOver",__mouseOver);
         removeEventListener("mouseOut",__mouseOut);
      }
      
      public function get info() : PropInfo
      {
         return _info;
      }
      
      public function setMode(mode:int) : void
      {
         _mode = mode;
         drawLayer();
      }
      
      public function set info(val:PropInfo) : void
      {
         var bitmap:* = null;
         ShowTipManager.Instance.removeTip(this);
         _info = val;
         var asset:DisplayObject = _asset;
         if(_info != null)
         {
            bitmap = ComponentFactory.Instance.creatBitmap("game.crazyTank.view.Prop" + _info.Template.Pic + "Asset");
            if(bitmap)
            {
               bitmap.smoothing = true;
               var _loc4_:int = 1;
               bitmap.y = _loc4_;
               bitmap.x = _loc4_;
               _loc4_ = 35;
               bitmap.height = _loc4_;
               bitmap.width = _loc4_;
               addChildAt(bitmap,getChildIndex(_fore));
            }
            _asset = bitmap;
            _tipInfo.info = _info.Template;
            _tipInfo.shortcutKey = _shortcutKey;
            ShowTipManager.Instance.addTip(this);
            buttonMode = true;
         }
         else
         {
            buttonMode = false;
         }
         if(asset != null)
         {
            ObjectUtils.disposeObject(asset);
         }
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function set enabled(val:Boolean) : void
      {
         if(_enabled != val)
         {
            _enabled = val;
            if(!_enabled)
            {
               filters = _grayFilters;
            }
            else
            {
               filters = null;
            }
         }
      }
      
      public function get isExist() : Boolean
      {
         return _isExist;
      }
      
      public function set isExist(val:Boolean) : void
      {
         _isExist = val;
      }
      
      public function setPossiton(x:int, y:int) : void
      {
         _x = x;
         _y = y;
         this.x = _x;
         this.y = _y;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ShowTipManager.Instance.removeTip(this);
         filters = null;
         if(_tweenMax)
         {
            _tweenMax.kill();
         }
         _tweenMax = null;
         ObjectUtils.disposeObject(_asset);
         _asset = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_fore);
         _fore = null;
         ObjectUtils.disposeObject(_shortcutKeyShape);
         _shortcutKeyShape = null;
         ObjectUtils.disposeObject(_bitmapMgr);
         _bitmapMgr = null;
         TweenLite.killTweensOf(this);
         ShowTipManager.Instance.removeTip(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function useProp() : void
      {
         if(_localVisible)
         {
            dispatchEvent(new MouseEvent("click"));
         }
      }
      
      public function get localVisible() : Boolean
      {
         return _localVisible;
      }
      
      public function setVisible(val:Boolean) : void
      {
         if(_localVisible != val)
         {
            _localVisible = val;
         }
      }
      
      public function set back(value:DisplayObject) : void
      {
         _back = value;
      }
   }
}
