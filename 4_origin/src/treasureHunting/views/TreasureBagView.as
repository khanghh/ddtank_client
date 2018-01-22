package treasureHunting.views
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import treasureHunting.TreasureControl;
   import treasureHunting.event.TreasureEvent;
   
   public class TreasureBagView extends Sprite implements Disposeable
   {
      
      public static const BAG_SIZE:int = 24;
       
      
      private var _bagBG:Bitmap;
      
      private var _baglist:BagListView;
      
      private var _getAllBtn:BaseButton;
      
      private var _convertBtn:BaseButton;
      
      private var _bagData:Dictionary;
      
      private var isBagUpdate:Boolean;
      
      public function TreasureBagView()
      {
         super();
         initData();
         initView();
         initEvent();
      }
      
      private function initData() : void
      {
         isBagUpdate = false;
         SocketManager.Instance.out.updateTreasureBag();
      }
      
      private function initView() : void
      {
         _bagBG = ComponentFactory.Instance.creat("treasureHunting.bagBG");
         addChild(_bagBG);
         _baglist = new BagListView(0,4,24);
         PositionUtils.setPos(_baglist,"treasureHunting.baglistPos");
         _baglist.vSpace = 4;
         _baglist.hSpace = 5;
         addChild(_baglist);
         _getAllBtn = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.bag.getAllBtn");
         addChild(_getAllBtn);
         _convertBtn = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.bag.convertBtn");
         addChild(_convertBtn);
      }
      
      private function initEvent() : void
      {
         _getAllBtn.addEventListener("click",onGetAllBtnClick);
         _convertBtn.addEventListener("click",onConvertBtnClick);
         _baglist.addEventListener("itemclick",onItemClick);
         TreasureControl.instance.addEventListener("movieComplete",onMovieComplete);
      }
      
      public function updateData(param1:Dictionary) : void
      {
         _bagData = param1;
         isBagUpdate = true;
         if(TreasureControl.instance.isMovieComplete)
         {
            updateBagFrame();
         }
      }
      
      private function onMovieComplete(param1:TreasureEvent) : void
      {
         if(isBagUpdate)
         {
            updateBagFrame();
         }
      }
      
      private function updateBagFrame() : void
      {
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _bagData;
         for(var _loc2_ in _bagData)
         {
            _loc1_ = PlayerManager.Instance.Self.CaddyBag.getItemAt(int(_loc2_));
            if(_baglist != null)
            {
               _baglist.setCellInfo(int(_loc2_),_loc1_);
            }
         }
         isBagUpdate = false;
      }
      
      private function onItemClick(param1:CellEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc4_:BagCell = param1.data as BagCell;
         var _loc3_:int = (_loc4_.info as InventoryItemInfo).Count;
         var _loc2_:int = _getBagType(_loc4_.info as InventoryItemInfo);
         SocketManager.Instance.out.sendMoveGoods(5,_loc4_.place,_loc2_,-1,_loc3_);
      }
      
      private function _getBagType(param1:InventoryItemInfo) : int
      {
         var _loc2_:int = 0;
         var _loc3_:* = param1.CategoryID;
         if(11 !== _loc3_)
         {
            if(10 !== _loc3_)
            {
               if(12 !== _loc3_)
               {
                  if(20 !== _loc3_)
                  {
                     if(53 !== _loc3_)
                     {
                        if(23 !== _loc3_)
                        {
                           if(30 !== _loc3_)
                           {
                              if(34 !== _loc3_)
                              {
                                 if(35 !== _loc3_)
                                 {
                                    if(36 !== _loc3_)
                                    {
                                       if(18 !== _loc3_)
                                       {
                                          if(32 !== _loc3_)
                                          {
                                             if(33 !== _loc3_)
                                             {
                                                _loc2_ = 0;
                                             }
                                          }
                                          _loc2_ = 13;
                                       }
                                    }
                                    addr28:
                                    _loc2_ = 1;
                                 }
                                 addr27:
                                 §§goto(addr28);
                              }
                              addr26:
                              §§goto(addr27);
                           }
                           addr25:
                           §§goto(addr26);
                        }
                        addr24:
                        §§goto(addr25);
                     }
                     addr23:
                     §§goto(addr24);
                  }
                  addr22:
                  §§goto(addr23);
               }
               addr21:
               §§goto(addr22);
            }
            §§goto(addr21);
         }
         else if(param1.Property1 == "31")
         {
            _loc2_ = 21;
         }
         else
         {
            _loc2_ = 1;
         }
         return _loc2_;
      }
      
      private function onGetAllBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.getAllTreasure();
      }
      
      private function onConvertBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendConvertScore(false);
         TreasureControl.instance.isAlert = true;
      }
      
      private function onAlertResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",onAlertResponse);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            SocketManager.Instance.out.sendSellAll();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function removeEvents() : void
      {
         if(_getAllBtn)
         {
            _getAllBtn.removeEventListener("click",onGetAllBtnClick);
         }
         if(_convertBtn)
         {
            _convertBtn.removeEventListener("click",onConvertBtnClick);
         }
         if(_baglist)
         {
            _baglist.removeEventListener("itemclick",onItemClick);
         }
         TreasureControl.instance.removeEventListener("movieComplete",onMovieComplete);
      }
      
      public function dispose() : void
      {
         if(_bagBG)
         {
            ObjectUtils.disposeObject(_bagBG);
         }
         _bagBG = null;
         if(_baglist)
         {
            ObjectUtils.disposeObject(_baglist);
         }
         _baglist = null;
         if(_getAllBtn)
         {
            ObjectUtils.disposeObject(_getAllBtn);
         }
         _getAllBtn = null;
         if(_convertBtn)
         {
            ObjectUtils.disposeObject(_convertBtn);
         }
         _convertBtn = null;
      }
      
      public function get convertBtn() : BaseButton
      {
         return _convertBtn;
      }
   }
}
