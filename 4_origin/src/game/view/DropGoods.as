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
      
      public function DropGoods(_container:DisplayObjectContainer, _goods:DisplayObject, _beginPoint:Point, _endPoint:Point, _goldNum:int)
      {
         super();
         container = _container;
         goods = _goods;
         beginPoint = _beginPoint;
         endPoint = _endPoint;
         goldNum = _goldNum;
      }
      
      public function start(type:int = 1) : void
      {
         if(goods == null || beginPoint == null)
         {
            return;
         }
         _type = type;
         goods.x = beginPoint.x;
         goods.y = beginPoint.y;
         container.addChild(goods);
         midPoint = getLinePoint(beginPoint);
         var p:Point = new Point(beginPoint.x - (beginPoint.x - midPoint.x) / 2,beginPoint.y - 200);
         goDown(midPoint,p);
         isOver = false;
      }
      
      private function getLinePoint(pot:Point) : Point
      {
         var k:int = 0;
         var point:Point = new Point();
         var space:* = 45;
         _goodsId = count;
         if(_type == 1)
         {
            k = 3;
            point.y = pot.y - 30;
         }
         else if(_type == 2)
         {
            k = 2;
            point.y = pot.y + Math.random() * 90 + 10;
         }
         if(count % 2 == 0 && pot.x - space * count / k > pot.x - 350)
         {
            point.x = pot.x - space * count / k;
         }
         else if(count % 2 == 1 && pot.x + space * count / k < pot.x + 300)
         {
            point.x = pot.x + space * count / k;
         }
         else
         {
            point.x = !!(count % 2)?pot.x + space * Math.random() * (count / k):Number(pot.x - space * Math.random() * (count / k));
         }
         if(container.localToGlobal(point).x < 100)
         {
            point.x = pot.x + space * count / k;
         }
         if(container.localToGlobal(point).x > 900)
         {
            point.x = pot.x - space * count / k;
         }
         count = Number(count) + 1;
         return point;
      }
      
      private function goDown(p1:Point, p2:Point) : void
      {
         SoundManager.instance.play("170");
         if(_type == 1)
         {
            tweenDown = TweenMax.to(goods,1.2 + _goodsId / 10,{
               "bezier":[{
                  "x":p2.x,
                  "y":p2.y
               },{
                  "x":p1.x,
                  "y":p1.y
               },{
                  "x":p1.x,
                  "y":p1.y
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
                  "x":p2.x,
                  "y":p2.y
               },{
                  "x":p1.x,
                  "y":beginPoint.y - 10
               },{
                  "x":p1.x,
                  "y":p1.y
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
         var p:* = null;
         tweenDown.kill();
         tweenDown = null;
         if(goods == null)
         {
            return;
         }
         if(_type == 1)
         {
            p = new Point(midPoint.x - (midPoint.x - endPoint.x) / 2,midPoint.y - 100);
            goodBox = ClassUtils.CreatInstance("asset.game.GoodFlashBox") as MovieClip;
            timeOutId = setTimeout(goPackUp,500 + _goodsId * 50,endPoint,p);
         }
         else if(_type == 2)
         {
            p = new Point(midPoint.x - (midPoint.x - endPoint.x) / 2,midPoint.y - 100);
            goodBox = ClassUtils.CreatInstance("asset.game.FlashLight") as MovieClip;
            timeOutId = setTimeout(goPackUp,600 + _goodsId * 100,endPoint,p);
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
      
      private function goPackUp(p1:Point, p2:Point) : void
      {
         p1 = p1;
         p2 = p2;
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
         var sp:* = null;
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
               sp = (goods as BaseCell).getContent();
               if(sp)
               {
                  sp.x = sp.x - sp.width / 2;
                  sp.y = sp.y - sp.height / 2;
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
         var mc:MovieClip = ClassUtils.CreatInstance("asset.game.bagAniam") as MovieClip;
         var pt:Point = ComponentFactory.Instance.creatCustomObject("dropGoods.bagPoint");
         mc.x = pt.x;
         mc.y = pt.y;
         var bagmc:MovieClipWrapper = new MovieClipWrapper(mc,true,true);
         return bagmc;
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
