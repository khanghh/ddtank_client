package petIsland.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import petIsland.PetIslandManager;
   
   public class PetIslandPrizeView extends Sprite
   {
       
      
      private var _line1_2:Bitmap;
      
      private var _line2_3:Bitmap;
      
      private var _line3_4:Bitmap;
      
      private var _line4_5:Bitmap;
      
      private var _prize1:MovieClip;
      
      private var _prize2:MovieClip;
      
      private var _prize3:MovieClip;
      
      private var _prize4:MovieClip;
      
      private var _prize5:MovieClip;
      
      private var _contain1:Component;
      
      private var _contain2:Component;
      
      private var _contain3:Component;
      
      private var _contain4:Component;
      
      private var _contain5:Component;
      
      private var lineArr:Array;
      
      private var prizeArr:Array;
      
      public function PetIslandPrizeView()
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         lineArr = [];
         prizeArr = [];
         super();
         _line1_2 = ComponentFactory.Instance.creatBitmap("asset.petIsland.prizeLine1_2");
         _line2_3 = ComponentFactory.Instance.creatBitmap("asset.petIsland.prizeLine2_3");
         _line3_4 = ComponentFactory.Instance.creatBitmap("asset.petIsland.prizeLine3_4");
         _line4_5 = ComponentFactory.Instance.creatBitmap("asset.petIsland.prizeLine4_5");
         lineArr.push(_line1_2);
         lineArr.push(_line2_3);
         lineArr.push(_line3_4);
         lineArr.push(_line4_5);
         var _loc3_:* = 0.5;
         _line4_5.alpha = _loc3_;
         _loc3_ = _loc3_;
         _line3_4.alpha = _loc3_;
         _loc3_ = _loc3_;
         _line2_3.alpha = _loc3_;
         _line1_2.alpha = _loc3_;
         _prize1 = ComponentFactory.Instance.creat("asset.petIsland.prize1");
         _prize2 = ComponentFactory.Instance.creat("asset.petIsland.prize2");
         _prize3 = ComponentFactory.Instance.creat("asset.petIsland.prize3");
         _prize4 = ComponentFactory.Instance.creat("asset.petIsland.prize4");
         _prize5 = ComponentFactory.Instance.creat("asset.petIsland.prize5");
         prizeArr.push(_prize1);
         prizeArr.push(_prize2);
         prizeArr.push(_prize3);
         prizeArr.push(_prize4);
         prizeArr.push(_prize5);
         _prize2.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         _prize3.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         _prize4.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         _prize5.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         _loc3_ = false;
         _prize5["round"].visible = _loc3_;
         _loc3_ = _loc3_;
         _prize4["round"].visible = _loc3_;
         _loc3_ = _loc3_;
         _prize3["round"].visible = _loc3_;
         _loc3_ = _loc3_;
         _prize2["round"].visible = _loc3_;
         _prize1["round"].visible = _loc3_;
         _prize1.gotoAndStop(1);
         _prize2.gotoAndStop(1);
         _prize3.gotoAndStop(1);
         _prize4.gotoAndStop(1);
         _prize5.gotoAndStop(1);
         _prize1.addEventListener("click",clickHandler);
         _prize2.addEventListener("click",clickHandler);
         _prize3.addEventListener("click",clickHandler);
         _prize4.addEventListener("click",clickHandler);
         _prize5.addEventListener("click",clickHandler);
         addChild(_line1_2);
         addChild(_line2_3);
         addChild(_line3_4);
         addChild(_line4_5);
         _contain1 = ComponentFactory.Instance.creatComponentByStylename("petIsland.collectionItem.itemTipContent");
         _contain2 = ComponentFactory.Instance.creatComponentByStylename("petIsland.collectionItem.itemTipContent");
         _contain3 = ComponentFactory.Instance.creatComponentByStylename("petIsland.collectionItem.itemTipContent");
         _contain4 = ComponentFactory.Instance.creatComponentByStylename("petIsland.collectionItem.itemTipContent");
         _contain5 = ComponentFactory.Instance.creatComponentByStylename("petIsland.collectionItem.itemTipContent");
         _contain1.addChild(_prize1);
         _contain2.addChild(_prize2);
         _contain3.addChild(_prize3);
         _contain4.addChild(_prize4);
         _contain5.addChild(_prize5);
         PositionUtils.setPos(_contain1,"asset.petIsland.prize1.position");
         PositionUtils.setPos(_contain2,"asset.petIsland.prize2.position");
         PositionUtils.setPos(_contain3,"asset.petIsland.prize3.position");
         PositionUtils.setPos(_contain4,"asset.petIsland.prize4.position");
         PositionUtils.setPos(_contain5,"asset.petIsland.prize5.position");
         _loc2_ = ItemManager.Instance.getTemplateById(201623);
         _loc1_ = new BagCell(0,_loc2_);
         _contain1.buttonMode = true;
         _contain1.tipData = _loc1_.tipData;
         _loc2_ = ItemManager.Instance.getTemplateById(201624);
         _loc1_ = new BagCell(0,_loc2_);
         _contain2.buttonMode = true;
         _contain2.tipData = _loc1_.tipData;
         _loc2_ = ItemManager.Instance.getTemplateById(201625);
         _loc1_ = new BagCell(0,_loc2_);
         _contain3.buttonMode = true;
         _contain3.tipData = _loc1_.tipData;
         _loc2_ = ItemManager.Instance.getTemplateById(201626);
         _loc1_ = new BagCell(0,_loc2_);
         _contain4.buttonMode = true;
         _contain4.tipData = _loc1_.tipData;
         _loc2_ = ItemManager.Instance.getTemplateById(201627);
         _loc1_ = new BagCell(0,_loc2_);
         _contain5.buttonMode = true;
         _contain5.tipData = _loc1_.tipData;
         addChild(_contain1);
         addChild(_contain2);
         addChild(_contain3);
         addChild(_contain4);
         addChild(_contain5);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = param1.currentTarget;
         if(_prize1 !== _loc3_)
         {
            if(_prize2 !== _loc3_)
            {
               if(_prize3 !== _loc3_)
               {
                  if(_prize4 !== _loc3_)
                  {
                     if(_prize5 === _loc3_)
                     {
                        _loc2_ = 5;
                     }
                  }
                  else
                  {
                     _loc2_ = 4;
                  }
               }
               else
               {
                  _loc2_ = 3;
               }
            }
            else
            {
               _loc2_ = 2;
            }
         }
         else
         {
            _loc2_ = 1;
         }
         if(_loc2_ >= PetIslandManager.instance.model.currentLevel)
         {
            return;
         }
         SocketManager.Instance.out.petIslandPrize(_loc2_);
      }
      
      public function setPrizeView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:Array = PetIslandManager.instance.model.rewardRecord.split("|");
         _loc3_ = 0;
         while(_loc3_ < PetIslandManager.instance.model.currentLevel)
         {
            if(_loc3_ != ServerConfigManager.instance.petDisappearMaxLevel)
            {
               if(_loc3_ != 0)
               {
                  lineArr[_loc3_ - 1].alpha = 1;
               }
               prizeArr[_loc3_].filters = null;
               _loc3_++;
               continue;
            }
            break;
         }
         if(PetIslandManager.instance.model.currentLevel <= ServerConfigManager.instance.petDisappearMaxLevel)
         {
            prizeArr[PetIslandManager.instance.model.currentLevel - 1]["round"].visible = true;
         }
         _loc2_ = 1;
         while(_loc2_ <= prizeArr.length)
         {
            if(_loc1_.indexOf(String(_loc2_)) == -1)
            {
               if(_loc2_ < PetIslandManager.instance.model.currentLevel)
               {
                  prizeArr[_loc2_ - 1].gotoAndStop(2);
               }
               else
               {
                  prizeArr[_loc2_ - 1].gotoAndStop(1);
               }
            }
            else
            {
               prizeArr[_loc2_ - 1].gotoAndStop(3);
            }
            _loc2_++;
         }
      }
   }
}
