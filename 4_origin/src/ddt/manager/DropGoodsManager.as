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
      
      public function DropGoodsManager(begin:Point, end:Point)
      {
         super();
         parentContainer = StageReferance.stage;
         beginPoint = begin;
         endPoint = end;
         goodsList = new Vector.<ItemTemplateInfo>();
         goodsTipList = new Vector.<ItemTemplateInfo>();
         timeOutIdArr = [];
         tweenArr = [];
      }
      
      public static function play(item:Array, begin:Point = null, end:Point = null, isEmailAniam:Boolean = false) : void
      {
         var i:int = 0;
         var itemInfo:* = null;
         var cell:* = null;
         var timeOutId:* = 0;
         _isEmailAniam = isEmailAniam;
         if(begin == null)
         {
            begin = ComponentFactory.Instance.creatCustomObject("dropGoodsManager.beginPoint");
         }
         if(end == null)
         {
            end = ComponentFactory.Instance.creatCustomObject("dropGoodsManager.bagPoint");
         }
         var dgm:DropGoodsManager = new DropGoodsManager(begin,end);
         dgm.setGoodsList(item);
         for(i = 0; i < dgm.goodsList.length; )
         {
            itemInfo = dgm.goodsList[i];
            cell = new BaseCell(new Sprite(),itemInfo);
            cell.setContentSize(48,48);
            timeOutId = uint(setTimeout(dgm.packUp,200 + i * 200,cell,dgm.onCompletePackUp));
            dgm.timeOutIdArr.push(timeOutId);
            i++;
         }
      }
      
      private function onPetCompletePackUp(goods:DisplayObject) : void
      {
         ObjectUtils.disposeObject(goods);
         dispose();
      }
      
      private function packUp(goods:DisplayObject, callBack:Function) : void
      {
         clearTimeout(timeOutIdArr.shift());
         goods.x = beginPoint.x;
         goods.y = beginPoint.y;
         goods.alpha = 0.5;
         goods.scaleX = 0.85;
         goods.scaleY = 0.85;
         parentContainer.addChild(goods);
         var p4:Point = endPoint;
         var p2:Point = new Point(beginPoint.x - (beginPoint.x - p4.x) / 2,beginPoint.y - 100);
         var p1:Point = new Point(p2.x - (p2.x - beginPoint.x) / 2,beginPoint.y - 60);
         var p3:Point = new Point(p4.x - (p4.x - p2.x) / 2,beginPoint.y + 30);
         var Vars1:TweenVars = ComponentFactory.Instance.creatCustomObject("dropGoodsManager.tweenVars1") as TweenVars;
         var Vars2:TweenVars = ComponentFactory.Instance.creatCustomObject("dropGoodsManager.tweenVars2") as TweenVars;
         var timeline:TimelineLite = new TimelineLite();
         timeline.append(TweenMax.to(goods,Vars1.duration,{
            "alpha":Vars1.alpha,
            "scaleX":Vars1.scaleX,
            "scaleY":Vars1.scaleY,
            "bezierThrough":[{
               "x":p1.x,
               "y":p1.y
            },{
               "x":p2.x,
               "y":p2.y
            }],
            "ease":Sine.easeInOut
         }));
         timeline.append(TweenMax.to(goods,Vars2.duration,{
            "alpha":Vars2.alpha,
            "scaleX":Vars2.scaleX,
            "scaleY":Vars2.scaleY,
            "bezierThrough":[{
               "x":p3.x,
               "y":p3.y
            },{
               "x":p4.x,
               "y":p4.y
            }],
            "ease":Sine.easeInOut,
            "onComplete":callBack,
            "onCompleteParams":[goods]
         }));
         tweenArr.push(timeline);
      }
      
      private function onCompletePackUp(goods:DisplayObject) : void
      {
         var emailMc:* = null;
         var bagMc:* = null;
         if(goods && parentContainer.contains(goods))
         {
            ObjectUtils.disposeObject(goods);
            goods = null;
         }
         if(_isEmailAniam)
         {
            emailMc = getEmailAniam();
            if(emailMc.movie)
            {
               parentContainer.addChild(emailMc.movie);
            }
         }
         else
         {
            bagMc = getBagAniam();
            if(bagMc.movie)
            {
               parentContainer.addChild(bagMc.movie);
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
         var mc:MovieClip = ClassUtils.CreatInstance("asset.toolbar.bagMCAsset") as MovieClip;
         var pt:Point = ComponentFactory.Instance.creatCustomObject("dropGoods.bagPoint");
         mc.x = pt.x;
         mc.y = pt.y;
         var bagmc:MovieClipWrapper = new MovieClipWrapper(mc,true,true);
         return bagmc;
      }
      
      private function getEmailAniam() : MovieClipWrapper
      {
         var mc:MovieClip = ClassUtils.CreatInstance("asset.playerInfo.mail") as MovieClip;
         var pt:Point = ComponentFactory.Instance.creatCustomObject("dropGoods.emailPoint");
         mc.x = pt.x;
         mc.y = pt.y;
         var bagmc:MovieClipWrapper = new MovieClipWrapper(mc,true,true);
         return bagmc;
      }
      
      private function setGoodsList(item:Array) : void
      {
         var i:int = 0;
         var j:int = 0;
         var len:int = 0;
         var typeNum:int = 0;
         var itemObj:* = null;
         var count:int = 0;
         var k:int = 0;
         var itemList:Array = [];
         for(i = 0; i < item.length; )
         {
            j = 0;
            while(true)
            {
               if(j >= goodsList.length)
               {
                  typeNum = 0;
                  itemObj = {};
                  for(j = 0; j < item.length; )
                  {
                     if(item[i].TemplateID == item[j].TemplateID)
                     {
                        typeNum++;
                     }
                     j++;
                  }
                  itemObj.item = item[i];
                  itemObj.count = typeNum;
                  itemList.push(itemObj);
                  break;
               }
               if(item[i].TemplateID != goodsList[j].TemplateID)
               {
                  j++;
                  continue;
               }
               break;
            }
            i++;
         }
         if(itemList.length > 7)
         {
            i = 0;
            while(i < itemList.length && i < 10)
            {
               goodsList.push(itemList[i].item);
               i++;
            }
         }
         else
         {
            i = 0;
            while(i < itemList.length)
            {
               count = itemList[i].count;
               if(count == 1)
               {
                  goodsList.push(itemList[i].item);
               }
               else if(count > 1 && count <= 3)
               {
                  len = Math.random() * 2 + 2;
                  for(k = 0; k < len; )
                  {
                     goodsList.push(itemList[i].item);
                     k++;
                  }
               }
               else if(count > 3)
               {
                  len = Math.random() * 3 + 2;
                  for(k = 0; k < len; )
                  {
                     goodsList.push(itemList[i].item);
                     k++;
                  }
               }
               i++;
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
