package ddt.manager
{
   import bagAndInfo.cell.BaseCell;
   import com.greensock.TimelineLite;
   import com.greensock.TweenMax;
   import com.greensock.easing.Sine;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.TweenVars;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import road7th.utils.MovieClipWrapper;
   
   public class DropGoodsManager implements Disposeable
   {
      
      private static var _isEmailAniam:Boolean = true;
       
      
      public var parentContainer:DisplayObjectContainer;
      
      public var beginPoint:Point;
      
      public var endPoint:Point;
      
      private var goodsList:Vector.<ItemTemplateInfo>;
      
      private var timeOutIdArr:Array;
      
      private var tweenArr:Array;
      
      private var intervalId:uint;
      
      private var goodsTipList:Vector.<ItemTemplateInfo>;
      
      private var _info:InventoryItemInfo;
      
      public function DropGoodsManager(param1:Point, param2:Point)
      {
         super();
         parentContainer = StageReferance.stage;
         beginPoint = param1;
         endPoint = param2;
         goodsList = new Vector.<ItemTemplateInfo>();
         goodsTipList = new Vector.<ItemTemplateInfo>();
         timeOutIdArr = [];
         tweenArr = [];
      }
      
      public static function play(param1:Array, param2:Point = null, param3:Point = null, param4:Boolean = false) : void
      {
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc5_:* = 0;
         _isEmailAniam = param4;
         if(param2 == null)
         {
            param2 = ComponentFactory.Instance.creatCustomObject("dropGoodsManager.beginPoint");
         }
         if(param3 == null)
         {
            param3 = ComponentFactory.Instance.creatCustomObject("dropGoodsManager.bagPoint");
         }
         var _loc9_:DropGoodsManager = new DropGoodsManager(param2,param3);
         _loc9_.setGoodsList(param1);
         _loc8_ = 0;
         while(_loc8_ < _loc9_.goodsList.length)
         {
            _loc7_ = _loc9_.goodsList[_loc8_];
            _loc6_ = new BaseCell(new Sprite(),_loc7_);
            _loc6_.setContentSize(48,48);
            _loc5_ = uint(setTimeout(_loc9_.packUp,200 + _loc8_ * 200,_loc6_,_loc9_.onCompletePackUp));
            _loc9_.timeOutIdArr.push(_loc5_);
            _loc8_++;
         }
      }
      
      private function onPetCompletePackUp(param1:DisplayObject) : void
      {
         ObjectUtils.disposeObject(param1);
         dispose();
      }
      
      private function packUp(param1:DisplayObject, param2:Function) : void
      {
         clearTimeout(timeOutIdArr.shift());
         param1.x = beginPoint.x;
         param1.y = beginPoint.y;
         param1.alpha = 0.5;
         param1.scaleX = 0.85;
         param1.scaleY = 0.85;
         parentContainer.addChild(param1);
         var _loc3_:Point = endPoint;
         var _loc5_:Point = new Point(beginPoint.x - (beginPoint.x - _loc3_.x) / 2,beginPoint.y - 100);
         var _loc6_:Point = new Point(_loc5_.x - (_loc5_.x - beginPoint.x) / 2,beginPoint.y - 60);
         var _loc4_:Point = new Point(_loc3_.x - (_loc3_.x - _loc5_.x) / 2,beginPoint.y + 30);
         var _loc8_:TweenVars = ComponentFactory.Instance.creatCustomObject("dropGoodsManager.tweenVars1") as TweenVars;
         var _loc9_:TweenVars = ComponentFactory.Instance.creatCustomObject("dropGoodsManager.tweenVars2") as TweenVars;
         var _loc7_:TimelineLite = new TimelineLite();
         _loc7_.append(TweenMax.to(param1,_loc8_.duration,{
            "alpha":_loc8_.alpha,
            "scaleX":_loc8_.scaleX,
            "scaleY":_loc8_.scaleY,
            "bezierThrough":[{
               "x":_loc6_.x,
               "y":_loc6_.y
            },{
               "x":_loc5_.x,
               "y":_loc5_.y
            }],
            "ease":Sine.easeInOut
         }));
         _loc7_.append(TweenMax.to(param1,_loc9_.duration,{
            "alpha":_loc9_.alpha,
            "scaleX":_loc9_.scaleX,
            "scaleY":_loc9_.scaleY,
            "bezierThrough":[{
               "x":_loc4_.x,
               "y":_loc4_.y
            },{
               "x":_loc3_.x,
               "y":_loc3_.y
            }],
            "ease":Sine.easeInOut,
            "onComplete":param2,
            "onCompleteParams":[param1]
         }));
         tweenArr.push(_loc7_);
      }
      
      private function onCompletePackUp(param1:DisplayObject) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1 && parentContainer.contains(param1))
         {
            ObjectUtils.disposeObject(param1);
            param1 = null;
         }
         if(_isEmailAniam)
         {
            _loc3_ = getEmailAniam();
            if(_loc3_.movie)
            {
               parentContainer.addChild(_loc3_.movie);
            }
         }
         else
         {
            _loc2_ = getBagAniam();
            if(_loc2_.movie)
            {
               parentContainer.addChild(_loc2_.movie);
            }
         }
         SoundManager.instance.play("008");
         if(tweenArr.length > 0)
         {
            tweenArr.shift().clear();
         }
         else
         {
            dispose();
         }
      }
      
      private function getBagAniam() : MovieClipWrapper
      {
         var _loc1_:MovieClip = ClassUtils.CreatInstance("asset.toolbar.bagMCAsset") as MovieClip;
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("dropGoods.bagPoint");
         _loc1_.x = _loc2_.x;
         _loc1_.y = _loc2_.y;
         var _loc3_:MovieClipWrapper = new MovieClipWrapper(_loc1_,true,true);
         return _loc3_;
      }
      
      private function getEmailAniam() : MovieClipWrapper
      {
         var _loc1_:MovieClip = ClassUtils.CreatInstance("asset.playerInfo.mail") as MovieClip;
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("dropGoods.emailPoint");
         _loc1_.x = _loc2_.x;
         _loc1_.y = _loc2_.y;
         var _loc3_:MovieClipWrapper = new MovieClipWrapper(_loc1_,true,true);
         return _loc3_;
      }
      
      private function setGoodsList(param1:Array) : void
      {
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:Array = [];
         _loc9_ = 0;
         while(_loc9_ < param1.length)
         {
            _loc6_ = 0;
            while(true)
            {
               if(_loc6_ >= goodsList.length)
               {
                  _loc8_ = 0;
                  _loc2_ = {};
                  _loc6_ = 0;
                  while(_loc6_ < param1.length)
                  {
                     if(param1[_loc9_].TemplateID == param1[_loc6_].TemplateID)
                     {
                        _loc8_++;
                     }
                     _loc6_++;
                  }
                  _loc2_.item = param1[_loc9_];
                  _loc2_.count = _loc8_;
                  _loc4_.push(_loc2_);
                  break;
               }
               if(param1[_loc9_].TemplateID != goodsList[_loc6_].TemplateID)
               {
                  _loc6_++;
                  continue;
               }
               break;
            }
            _loc9_++;
         }
         if(_loc4_.length > 7)
         {
            _loc9_ = 0;
            while(_loc9_ < _loc4_.length && _loc9_ < 10)
            {
               goodsList.push(_loc4_[_loc9_].item);
               _loc9_++;
            }
         }
         else
         {
            _loc9_ = 0;
            while(_loc9_ < _loc4_.length)
            {
               _loc3_ = _loc4_[_loc9_].count;
               if(_loc3_ == 1)
               {
                  goodsList.push(_loc4_[_loc9_].item);
               }
               else if(_loc3_ > 1 && _loc3_ <= 3)
               {
                  _loc5_ = Math.random() * 2 + 2;
                  _loc7_ = 0;
                  while(_loc7_ < _loc5_)
                  {
                     goodsList.push(_loc4_[_loc9_].item);
                     _loc7_++;
                  }
               }
               else if(_loc3_ > 3)
               {
                  _loc5_ = Math.random() * 3 + 2;
                  _loc7_ = 0;
                  while(_loc7_ < _loc5_)
                  {
                     goodsList.push(_loc4_[_loc9_].item);
                     _loc7_++;
                  }
               }
               _loc9_++;
            }
         }
      }
      
      public function dispose() : void
      {
         parentContainer = null;
         beginPoint = null;
         endPoint = null;
         goodsList = null;
         timeOutIdArr = null;
         while(tweenArr.length > 0)
         {
            tweenArr.shift().clear();
         }
         tweenArr = null;
         goodsTipList = null;
         _info = null;
      }
   }
}
