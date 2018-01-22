package game.view
{
   import bagAndInfo.cell.BaseCell;
   import com.greensock.TimelineLite;
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.greensock.easing.Bounce;
   import com.greensock.easing.Quint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import road7th.utils.MovieClipWrapper;
   
   public class DropGoods implements Disposeable
   {
      
      public static var count:int;
      
      public static var isOver:Boolean = true;
       
      
      private var goodBox:MovieClip;
      
      private var bagMc:MovieClipWrapper;
      
      private var goldNumText:FilterFrameText;
      
      private var goods:DisplayObject;
      
      private var container:DisplayObjectContainer;
      
      private var goldNum:int;
      
      private var beginPoint:Point;
      
      private var midPoint:Point;
      
      private var endPoint:Point;
      
      private var headGlow:MovieClip;
      
      private var _type:int;
      
      private var timeId:uint;
      
      private var timeOutId:uint;
      
      public const MONSTER_DROP:int = 1;
      
      public const CHESTS_DROP:int = 2;
      
      private var _goodsId:int;
      
      private var currentCount:int;
      
      private var tweenUp:TweenMax;
      
      private var tweenDown:TweenMax;
      
      private var timeline:TimelineLite;
      
      public function DropGoods(param1:DisplayObjectContainer, param2:DisplayObject, param3:Point, param4:Point, param5:int)
      {
         super();
         container = param1;
         goods = param2;
         beginPoint = param3;
         endPoint = param4;
         goldNum = param5;
      }
      
      public function start(param1:int = 1) : void
      {
         if(goods == null || beginPoint == null)
         {
            return;
         }
         _type = param1;
         goods.x = beginPoint.x;
         goods.y = beginPoint.y;
         container.addChild(goods);
         midPoint = getLinePoint(beginPoint);
         var _loc2_:Point = new Point(beginPoint.x - (beginPoint.x - midPoint.x) / 2,beginPoint.y - 200);
         goDown(midPoint,_loc2_);
         isOver = false;
      }
      
      private function getLinePoint(param1:Point) : Point
      {
         var _loc4_:int = 0;
         var _loc2_:Point = new Point();
         var _loc3_:* = 45;
         _goodsId = count;
         if(_type == 1)
         {
            _loc4_ = 3;
            _loc2_.y = param1.y - 30;
         }
         else if(_type == 2)
         {
            _loc4_ = 2;
            _loc2_.y = param1.y + Math.random() * 90 + 10;
         }
         if(count % 2 == 0 && param1.x - _loc3_ * count / _loc4_ > param1.x - 350)
         {
            _loc2_.x = param1.x - _loc3_ * count / _loc4_;
         }
         else if(count % 2 == 1 && param1.x + _loc3_ * count / _loc4_ < param1.x + 300)
         {
            _loc2_.x = param1.x + _loc3_ * count / _loc4_;
         }
         else
         {
            _loc2_.x = !!(count % 2)?param1.x + _loc3_ * Math.random() * (count / _loc4_):Number(param1.x - _loc3_ * Math.random() * (count / _loc4_));
         }
         if(container.localToGlobal(_loc2_).x < 100)
         {
            _loc2_.x = param1.x + _loc3_ * count / _loc4_;
         }
         if(container.localToGlobal(_loc2_).x > 900)
         {
            _loc2_.x = param1.x - _loc3_ * count / _loc4_;
         }
         count = Number(count) + 1;
         return _loc2_;
      }
      
      private function goDown(param1:Point, param2:Point) : void
      {
         SoundManager.instance.play("170");
         if(_type == 1)
         {
            tweenDown = TweenMax.to(goods,1.2 + _goodsId / 10,{
               "bezier":[{
                  "x":param2.x,
                  "y":param2.y
               },{
                  "x":param1.x,
                  "y":param1.y
               },{
                  "x":param1.x,
                  "y":param1.y
               }],
               "scaleX":1,
               "scaleY":1,
               "ease":Bounce.easeOut,
               "onComplete":__onCompleteGodown
            });
         }
         else if(_type == 2)
         {
            tweenDown = TweenMax.to(goods,1.2 + _goodsId / 10,{
               "bezier":[{
                  "x":param2.x,
                  "y":param2.y
               },{
                  "x":param1.x,
                  "y":beginPoint.y - 10
               },{
                  "x":param1.x,
                  "y":param1.y
               }],
               "scaleX":1,
               "scaleY":1,
               "ease":Bounce.easeOut,
               "onComplete":__onCompleteGodown
            });
         }
      }
      
      private function __onCompleteGodown() : void
      {
         var _loc1_:* = null;
         tweenDown.kill();
         tweenDown = null;
         if(goods == null)
         {
            return;
         }
         if(_type == 1)
         {
            _loc1_ = new Point(midPoint.x - (midPoint.x - endPoint.x) / 2,midPoint.y - 100);
            goodBox = ClassUtils.CreatInstance("asset.game.GoodFlashBox") as MovieClip;
            timeOutId = setTimeout(goPackUp,500 + _goodsId * 50,endPoint,_loc1_);
         }
         else if(_type == 2)
         {
            _loc1_ = new Point(midPoint.x - (midPoint.x - endPoint.x) / 2,midPoint.y - 100);
            goodBox = ClassUtils.CreatInstance("asset.game.FlashLight") as MovieClip;
            timeOutId = setTimeout(goPackUp,600 + _goodsId * 100,endPoint,_loc1_);
         }
         goodBox.x = goods.x;
         goodBox.y = goods.y;
         goods.x = 0;
         goods.y = 0;
         goodBox.gotoAndPlay(int(Math.random() * goodBox.totalFrames));
         goodBox.box.addChild(goods);
         container.addChild(goodBox);
         SoundManager.instance.play("172");
      }
      
      private function goPackUp(param1:Point, param2:Point) : void
      {
         p1 = param1;
         p2 = param2;
         clearTimeout(timeOutId);
         if(goods == null)
         {
            return;
         }
         if(container.contains(goodBox))
         {
            container.removeChild(goodBox);
         }
         goods.x = goodBox.x;
         goods.y = goodBox.y;
         if(_type == 1)
         {
            container.addChild(goods);
            tweenUp = TweenMax.to(goods,0.8,{
               "alpha":0,
               "scaleX":0.5,
               "scaleY":0.5,
               "bezierThrough":[{
                  "x":p2.x,
                  "y":p2.y
               },{
                  "x":p1.x,
                  "y":p1.y
               }],
               "ease":Quint.easeInOut,
               "orientToBezier":true,
               "onComplete":onCompletePackUp
            });
         }
         else if(_type == 2)
         {
            var p:Point = container.localToGlobal(new Point(goods.x,goods.y));
            goods.x = p.x;
            goods.y = p.y;
            container.stage.addChild(goods);
            var p2:Point = container.localToGlobal(p2);
            var p1:Point = new Point(650,550);
            tweenUp = TweenMax.to(goods,0.8,{
               "alpha":0.5,
               "scaleX":0.5,
               "scaleY":0.5,
               "bezierThrough":[{
                  "x":p2.x,
                  "y":p2.y
               },{
                  "x":p1.x,
                  "y":p1.y
               }],
               "ease":Quint.easeInOut,
               "orientToBezier":true,
               "onComplete":onCompletePackUp
            });
         }
         goldNumText = ComponentFactory.Instance.creatComponentByStylename("dropGoods.goldNumText");
         if(goldNumText)
         {
            goldNumText.x = midPoint.x;
            goldNumText.y = midPoint.y;
            goldNumText.text = goldNum.toString();
            container.addChild(goldNumText);
            var tl:TweenLite = TweenLite.to(goldNumText,1,{
               "y":midPoint.y - 200,
               "alpha":0,
               "onComplete":function():void
               {
                  tl.kill();
               }
            });
         }
      }
      
      private function onCompletePackUp() : void
      {
         var _loc1_:* = null;
         tweenUp.kill();
         tweenUp = null;
         if(goods == null)
         {
            return;
         }
         if(goldNumText && container.contains(goldNumText))
         {
            container.removeChild(goldNumText);
         }
         if(_type == 1)
         {
            timeline = new TimelineLite();
            if(goods is BaseCell)
            {
               _loc1_ = (goods as BaseCell).getContent();
               if(_loc1_)
               {
                  _loc1_.x = _loc1_.x - _loc1_.width / 2;
                  _loc1_.y = _loc1_.y - _loc1_.height / 2;
               }
            }
            headGlow = ClassUtils.CreatInstance("asset.game.HeadGlow") as MovieClip;
            headGlow.x = endPoint.x;
            headGlow.y = endPoint.y;
            container.addChild(headGlow);
            var _loc2_:* = 0;
            goods.rotationZ = _loc2_;
            _loc2_ = _loc2_;
            goods.rotationY = _loc2_;
            goods.rotationX = _loc2_;
            timeline.append(TweenLite.to(goods,0.2,{
               "alpha":1,
               "scaleX":0.8,
               "scaleY":0.8,
               "x":goods.x + 5,
               "y":goods.y - 50
            }));
            timeline.append(TweenLite.to(goods,0.4,{
               "y":goods.y - 150,
               "alpha":0.2,
               "rotationY":1800,
               "onComplete":completeHead
            }));
         }
         else if(_type == 2)
         {
            if(goods && container.stage.contains(goods))
            {
               container.stage.removeChild(goods);
            }
            bagMc = getBagAniam();
            if(bagMc.movie)
            {
               container.stage.addChild(bagMc.movie);
            }
            timeId = setTimeout(dispose,500);
            currentCount = count;
         }
         SoundManager.instance.play("171");
      }
      
      private function completeHead() : void
      {
         timeline.kill();
         timeline = null;
         if(goods && container.contains(goods))
         {
            container.removeChild(goods);
         }
         timeId = setTimeout(dispose,500);
         currentCount = count;
      }
      
      private function getBagAniam() : MovieClipWrapper
      {
         var _loc1_:MovieClip = ClassUtils.CreatInstance("asset.game.bagAniam") as MovieClip;
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("dropGoods.bagPoint");
         _loc1_.x = _loc2_.x;
         _loc1_.y = _loc2_.y;
         var _loc3_:MovieClipWrapper = new MovieClipWrapper(_loc1_,true,true);
         return _loc3_;
      }
      
      public function dispose() : void
      {
         clearTimeout(timeId);
         clearTimeout(timeOutId);
         ObjectUtils.disposeObject(goods);
         goods = null;
         if(goldNumText)
         {
            TweenLite.killTweensOf(goldNumText);
            ObjectUtils.disposeObject(goldNumText);
            goldNumText = null;
         }
         ObjectUtils.disposeObject(headGlow);
         headGlow = null;
         ObjectUtils.disposeObject(goodBox);
         goodBox = null;
         if(bagMc)
         {
            bagMc.dispose();
            bagMc = null;
         }
         goods = null;
         if(currentCount == count)
         {
            isOver = true;
         }
         count = 0;
      }
   }
}
