package hallIcon.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import hallIcon.HallIconManager;
   
   public class HallIconPanel extends Sprite implements Disposeable
   {
      
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
      
      public static const BOTTOM:String = "bottom";
       
      
      private var _mainIcon:DisplayObject;
      
      private var _mainIconString:String;
      
      private var _hotNumBg:Bitmap;
      
      private var _hotNum:FilterFrameText;
      
      private var _iconArray:Array;
      
      private var _iconBox:HallIconBox;
      
      private var direction:String;
      
      private var vNum:int;
      
      private var hNum:int;
      
      private var WHSize:Array;
      
      private var tweenLiteMax:TweenLite;
      
      private var tweenLiteSmall:TweenLite;
      
      private var isExpand:Boolean;
      
      public function HallIconPanel($mainIconString:String, $direction:String = "left", $hNum:int = -1, $vNum:int = -1, $WHSize:Array = null)
      {
         super();
         _mainIconString = $mainIconString;
         direction = $direction;
         hNum = $hNum;
         vNum = $vNum;
         if(hNum == -1 && vNum == -1)
         {
            vNum = 1;
         }
         if($WHSize == null)
         {
            $WHSize = [78,78];
         }
         WHSize = $WHSize;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _mainIcon = ComponentFactory.Instance.creat(_mainIconString);
         if(_mainIcon is Sprite)
         {
            Sprite(_mainIcon).buttonMode = true;
            Sprite(_mainIcon).mouseChildren = false;
         }
         addChild(_mainIcon);
         _hotNumBg = ComponentFactory.Instance.creatBitmap("assets.hallIcon.hotNumBg");
         addChild(_hotNumBg);
         _hotNum = ComponentFactory.Instance.creatComponentByStylename("hallicon.hallIconPanel.hotNum");
         _hotNum.text = "0";
         addChild(_hotNum);
         updateHotNum();
         _iconArray = [];
         _iconBox = new HallIconBox();
         _iconBox.visible = false;
         addChild(_iconBox);
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("click",__mainIconHandler);
      }
      
      public function addIcon($icon:DisplayObject, $icontype:String, $orderId:int = 0, flag:Boolean = false) : DisplayObject
      {
         _iconBox.addChild($icon);
         var obj:Object = {};
         obj.icon = $icon;
         obj.icontype = $icontype;
         obj.orderId = $orderId;
         obj.flag = flag;
         _iconArray.push(obj);
         arrange();
         return $icon;
      }
      
      public function getIconByType($icontype:String) : DisplayObject
      {
         var tempChild:* = null;
         var i:int = 0;
         var tempType:* = null;
         for(i = 0; i < _iconArray.length; )
         {
            tempType = _iconArray[i].icontype;
            if(tempType == $icontype)
            {
               tempChild = _iconArray[i].icon;
               break;
            }
            i++;
         }
         return tempChild;
      }
      
      public function removeIconByType($icontype:String) : void
      {
         var tempChild:* = null;
         var i:int = 0;
         var tempIconType:* = null;
         var tempIndex:int = 0;
         for(i = 0; i < _iconArray.length; )
         {
            tempIconType = _iconArray[i].icontype;
            if(tempIconType == $icontype)
            {
               tempChild = _iconArray[i].icon;
               _iconArray.splice(i,1);
               break;
            }
            i++;
         }
         if(tempChild)
         {
            tempIndex = _iconBox.getChildIndex(tempChild);
            if(tempIndex != -1)
            {
               _iconBox.removeChildAt(tempIndex);
            }
         }
         if(tempChild)
         {
            ObjectUtils.disposeObject(tempChild);
         }
         arrange();
      }
      
      public function arrange() : void
      {
         iconSortOn();
         updateIconsPos();
         if(isExpand)
         {
            updateDirectionPos();
         }
         updateHotNum();
      }
      
      private function updateIconsPos() : void
      {
         var i:int = 0;
         var tempChild:* = null;
         for(i = 0; i < _iconArray.length; )
         {
            tempChild = _iconArray[i].icon;
            if(hNum == -1)
            {
               tempChild.x = i * WHSize[0];
            }
            else
            {
               tempChild.x = int(i % hNum) * WHSize[0];
            }
            if(vNum == -1)
            {
               tempChild.y = int(i / hNum) * WHSize[1];
            }
            else
            {
               tempChild.y = i * WHSize[1];
            }
            i++;
         }
      }
      
      private function updateDirectionPos() : void
      {
         if(direction == "left")
         {
            _iconBox.x = -getIconSpriteWidth() - 10;
            _iconBox.y = -(getIconSpriteHeight() - WHSize[1]) / 2;
         }
         else if(direction == "right")
         {
            _iconBox.x = _mainIcon.x + _mainIcon.width + 10;
            _iconBox.y = -(getIconSpriteHeight() - WHSize[1]) / 2;
         }
         else if(direction == "bottom")
         {
            if(HallIconManager.instance.model.firstRechargeIsOpen && _iconArray[0].flag)
            {
               _iconBox.x = -350;
            }
            else
            {
               _iconBox.x = -(getIconSpriteWidth() - WHSize[0]);
            }
            _iconBox.y = _mainIcon.y + WHSize[1] + 5;
         }
      }
      
      public function iconSortOn() : void
      {
         if(_iconArray.length > 1)
         {
            _iconArray.sort(sortFunctin);
         }
      }
      
      private function sortFunctin(a:Object, b:Object) : Number
      {
         if(a.orderId > b.orderId)
         {
            return 1;
         }
         if(a.orderId < b.orderId)
         {
            return -1;
         }
         return 0;
      }
      
      public function expand($isBool:Boolean) : void
      {
         var moveX:* = NaN;
         var moveY:* = NaN;
         if(isExpand != $isBool && _iconArray && _iconArray.length > 0)
         {
            isExpand = $isBool;
            if(isExpand)
            {
               moveX = 0;
               moveY = 0;
               if(direction == "left")
               {
                  moveX = Number(-getIconSpriteWidth() - 10);
                  moveY = Number(-(getIconSpriteHeight() - WHSize[1]) / 2);
               }
               else if(direction == "right")
               {
                  moveX = Number(_mainIcon.x + _mainIcon.width + 10);
                  moveY = Number(-(getIconSpriteHeight() - WHSize[1]) / 2);
               }
               else if(direction == "bottom")
               {
                  if(HallIconManager.instance.model.firstRechargeIsOpen && _iconArray[0].flag)
                  {
                     moveX = Number(-350);
                  }
                  else
                  {
                     moveX = Number(-(getIconSpriteWidth() - WHSize[0]));
                  }
                  moveY = Number(_mainIcon.y + WHSize[1] + 5);
               }
               _iconBox.x = _mainIcon.x;
               _iconBox.y = 0;
               _iconBox.scaleX = 0;
               _iconBox.scaleY = 0;
               _iconBox.alpha = 0;
               _iconBox.visible = true;
               tweenLiteMax = TweenLite.to(_iconBox,0.2,{
                  "x":moveX,
                  "y":moveY,
                  "alpha":1,
                  "scaleX":1,
                  "scaleY":1,
                  "onComplete":tweenLiteMaxCloseComplete
               });
            }
            else
            {
               tweenLiteSmall = TweenLite.to(_iconBox,0.2,{
                  "x":_mainIcon.x,
                  "y":0,
                  "alpha":0,
                  "scaleX":0,
                  "scaleY":0,
                  "onComplete":tweenLiteSmallCloseComplete
               });
            }
         }
      }
      
      private function tweenLiteSmallCloseComplete() : void
      {
         killTweenLiteSmall();
         _iconBox.visible = false;
      }
      
      private function tweenLiteMaxCloseComplete() : void
      {
         killTweenLiteMax();
      }
      
      private function getIconSpriteWidth() : Number
      {
         var tempW:* = 0;
         if(_iconArray.length == 0)
         {
            tempW = 0;
         }
         else if(hNum == -1)
         {
            tempW = Number(_iconArray.length * WHSize[0]);
         }
         else if(_iconArray.length >= hNum)
         {
            tempW = Number(hNum * WHSize[0]);
         }
         else
         {
            tempW = Number(_iconArray.length * WHSize[0]);
         }
         return tempW;
      }
      
      private function getIconSpriteHeight() : Number
      {
         var tempN:int = 0;
         var tempH:* = 0;
         if(_iconArray.length == 0)
         {
            tempH = 0;
         }
         else if(hNum == -1)
         {
            tempH = Number(WHSize[1]);
         }
         else if(_iconArray.length >= hNum)
         {
            tempN = _iconArray.length / hNum;
            if(_iconArray.length % hNum)
            {
               tempN = tempN + 1;
            }
            tempH = Number(tempN * WHSize[1]);
         }
         else
         {
            tempH = Number(WHSize[1]);
         }
         return tempH;
      }
      
      public function removeChildrens() : void
      {
         _iconBox.removeChildren();
         _iconArray = [];
      }
      
      private function __mainIconHandler(evt:MouseEvent) : void
      {
         if(evt.target == _mainIcon)
         {
            SoundManager.instance.play("008");
            if(_iconArray && _iconArray.length > 0)
            {
               !!_iconBox.visible?expand(false):expand(true);
            }
         }
         else
         {
            expand(false);
         }
      }
      
      private function updateHotNum() : void
      {
         var isBool:Boolean = false;
         if(_iconArray && _iconArray.length > 0)
         {
            isBool = true;
            _hotNum.text = _iconArray.length + "";
         }
         else
         {
            _hotNum.text = "0";
         }
         var _loc2_:* = isBool;
         _hotNum.visible = _loc2_;
         _hotNumBg.visible = _loc2_;
      }
      
      public function get mainIcon() : DisplayObject
      {
         return _mainIcon;
      }
      
      public function get count() : int
      {
         return _iconArray.length;
      }
      
      override public function get height() : Number
      {
         if(_mainIcon)
         {
            return _mainIcon.height;
         }
         return 0;
      }
      
      override public function get width() : Number
      {
         if(_mainIcon)
         {
            return _mainIcon.width;
         }
         return 0;
      }
      
      private function killTweenLiteMax() : void
      {
         if(!tweenLiteMax)
         {
            return;
         }
         tweenLiteMax.kill();
         tweenLiteMax = null;
      }
      
      private function killTweenLiteSmall() : void
      {
         if(!tweenLiteSmall)
         {
            return;
         }
         tweenLiteSmall.kill();
         tweenLiteSmall = null;
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("click",__mainIconHandler);
      }
      
      public function dispose() : void
      {
         killTweenLiteMax();
         killTweenLiteSmall();
         removeEvent();
         ObjectUtils.disposeObject(_mainIcon);
         _mainIcon = null;
         ObjectUtils.disposeObject(_hotNumBg);
         _hotNumBg = null;
         ObjectUtils.disposeObject(_hotNum);
         _hotNum = null;
         ObjectUtils.disposeObject(_iconBox);
         _iconBox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _iconArray = null;
         WHSize = null;
         direction = null;
         _mainIconString = null;
         vNum = 0;
         hNum = 0;
      }
   }
}
