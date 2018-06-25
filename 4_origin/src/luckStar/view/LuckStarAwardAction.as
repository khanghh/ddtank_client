package luckStar.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import luckStar.manager.LuckStarManager;
   
   public class LuckStarAwardAction extends Sprite implements Disposeable
   {
       
      
      private var _action:MovieClip;
      
      private var _list:Vector.<Bitmap>;
      
      private var _cell:Function;
      
      private var _num:Vector.<ScaleFrameImage>;
      
      private var _count:int = 0;
      
      private var len:int;
      
      private var arr:Array;
      
      private var _isMaxAward:Boolean;
      
      private var _mc:MovieClip;
      
      private var _image:Bitmap;
      
      private var _content:Sprite;
      
      private var _move:Point;
      
      private var _tweenMax:TweenMax;
      
      public function LuckStarAwardAction()
      {
         arr = [9,99,999,9999,99999,999999,9999999];
         super();
      }
      
      public function playAction(cell:Function, btm:DisplayObject, move:Point, isMaxAward:Boolean = false) : void
      {
         _cell = cell;
         _isMaxAward = isMaxAward;
         if(_isMaxAward)
         {
            playMaxAwardAction();
            return;
         }
         _content = new Sprite();
         addChild(_content);
         _image = btm as Bitmap;
         _move = move;
         var rect:Rectangle = ComponentFactory.Instance.creatCustomObject("luckyStar.view.AwardLightRec");
         _mc = ComponentFactory.Instance.creat("luckyStar.view.TurnMC");
         _mc.stop();
         var _loc6_:* = rect.width;
         _mc.height = _loc6_;
         _mc.width = _loc6_;
         _mc.x = rect.x;
         _mc.y = rect.y;
         _mc.gotoAndPlay(1);
         _mc.addEventListener("enterFrame",__onEnter);
         _content.addChild(_mc);
      }
      
      private function playNextAction() : void
      {
         if(_image)
         {
            var _loc1_:* = -2;
            _image.y = _loc1_;
            _image.x = _loc1_;
            _loc1_ = 0.8;
            _image.scaleY = _loc1_;
            _image.scaleX = _loc1_;
            _content.addChild(_image);
         }
      }
      
      private function __onEnter(e:Event) : void
      {
         if(_mc.currentFrame == 40)
         {
            SoundManager.instance.play("125");
            playNextAction();
         }
         if(_mc.currentFrame == 65)
         {
            _tweenMax = TweenMax.to(_content,0.7,{
               "x":_move.x,
               "y":_move.y,
               "width":60,
               "height":60
            });
         }
         if(_mc.currentFrame == _mc.totalFrames - 1)
         {
            disposeAction();
         }
      }
      
      public function get actionDisplay() : Sprite
      {
         return _content;
      }
      
      private function disposeAction() : void
      {
         if(_mc)
         {
            _mc.stop();
            _mc.removeEventListener("enterFrame",__onEnter);
            ObjectUtils.disposeObject(_mc);
            _mc = null;
         }
         if(_image)
         {
            ObjectUtils.disposeObject(_image);
            _image = null;
         }
         if(_tweenMax)
         {
            TweenMax.killChildTweensOf(_content);
         }
         _tweenMax = null;
         ObjectUtils.disposeObject(_content);
         _content = null;
         if(_cell != null)
         {
            _cell.apply();
         }
         _cell = null;
      }
      
      public function playMaxAwardAction() : void
      {
         LayerManager.Instance.addToLayer(this,3,false,1);
         _list = new Vector.<Bitmap>();
         _num = new Vector.<ScaleFrameImage>();
         _count = LuckStarManager.Instance.model.coins;
         _action = ComponentFactory.Instance.creat("luckyStar.view.maxAwardAction");
         PositionUtils.setPos(_action,"luckyStar.view.maxAwardActionPos");
         addChild(_action);
         _action.addEventListener("enterFrame",__onAction);
         _action.gotoAndPlay(1);
         SoundManager.instance.play("210");
      }
      
      private function setupCount() : void
      {
         var i:int = 0;
         while(len > _num.length)
         {
            _num.unshift(createCoinsNum(0));
         }
         while(len < _num.length)
         {
            ObjectUtils.disposeObject(_num.shift());
         }
         var cha:int = 8 - len;
         var numX:int = cha / 2 * 25;
         for(i = 0; i < len; )
         {
            _num[i].x = numX + 280;
            _num[i].y = 200;
            numX = numX + 25;
            i++;
         }
      }
      
      private function playCount() : void
      {
         setupCount();
         if(len == 0 || len > arr.length)
         {
            return;
         }
         var random:int = Math.random() * int(arr[len - 1]);
         updateCoinsView(random.toString().split(""));
      }
      
      private function updateCoinsView(arr:Array) : void
      {
         var i:int = 0;
         for(i = 0; i < len; )
         {
            if(arr[i] == 0)
            {
               arr[i] = 10;
            }
            _num[i].setFrame(arr[i]);
            i++;
         }
      }
      
      private function __onAction(e:Event) : void
      {
         updateCoinsView(_count.toString().split(""));
         if(_action.currentFrame < 165)
         {
            if(_action.currentFrame % 20 == 0)
            {
               len = Number(len) + 1;
               if(len > _count.toString().length)
               {
                  len = _count.toString().length;
               }
               SoundManager.instance.play("210");
            }
            playCount();
            coinsDrop();
         }
         checkDrop();
         if(_action.currentFrame == _action.totalFrames - 1)
         {
            len = 0;
            _action.stop();
            _action.removeEventListener("enterFrame",__onAction);
            _action = null;
            if(_cell != null)
            {
               _cell.apply();
            }
            _cell = null;
         }
      }
      
      private function coinsDrop() : void
      {
         var index:int = Math.random() * 3;
         var btm:Bitmap = ComponentFactory.Instance.creatBitmap("luckyStar.view.CoinsRain" + index);
         btm.x = Math.random() * 700 + 100;
         _list.push(btm);
         addChildAt(btm,0);
      }
      
      private function checkDrop() : void
      {
         var i:int = 0;
         for(i = 0; i < _list.length; )
         {
            _list[i].y = _list[i].y + 30;
            if(_list[i].y > 500)
            {
               ObjectUtils.disposeObject(_list[i]);
               _list.splice(_list.indexOf(_list[i]),_list.indexOf(_list[i]));
            }
            i++;
         }
      }
      
      private function createCoinsNum(frame:int = 0) : ScaleFrameImage
      {
         var num:ScaleFrameImage = ComponentFactory.Instance.creatComponentByStylename("luckyStar.view.CoinsNum");
         num.setFrame(frame);
         if(_action)
         {
            _action.addChild(num);
         }
         return num;
      }
      
      public function dispose() : void
      {
         while(_list && _list.length)
         {
            ObjectUtils.disposeObject(_list.pop());
         }
         _list = null;
         while(_num && _num.length)
         {
            ObjectUtils.disposeObject(_num.pop());
         }
         _num = null;
         _cell = null;
         if(_action)
         {
            _action.stop();
            _action.removeEventListener("enterFrame",__onAction);
         }
         _action = null;
      }
   }
}
