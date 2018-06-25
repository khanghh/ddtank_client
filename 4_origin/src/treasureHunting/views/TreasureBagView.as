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
      
      public function updateData(data:Dictionary) : void
      {
         _bagData = data;
         isBagUpdate = true;
         if(TreasureControl.instance.isMovieComplete)
         {
            updateBagFrame();
         }
      }
      
      private function onMovieComplete(event:TreasureEvent) : void
      {
         if(isBagUpdate)
         {
            updateBagFrame();
         }
      }
      
      private function updateBagFrame() : void
      {
         var cellInfo:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _bagData;
         for(var i in _bagData)
         {
            cellInfo = PlayerManager.Instance.Self.CaddyBag.getItemAt(int(i));
            if(_baglist != null)
            {
               _baglist.setCellInfo(int(i),cellInfo);
            }
         }
         isBagUpdate = false;
      }
      
      private function onItemClick(event:CellEvent) : void
      {
         SoundManager.instance.play("008");
         var item:BagCell = event.data as BagCell;
         var count:int = (item.info as InventoryItemInfo).Count;
         var bagType:int = _getBagType(item.info as InventoryItemInfo);
         SocketManager.Instance.out.sendMoveGoods(5,item.place,bagType,-1,count);
      }
      
      private function _getBagType(info:InventoryItemInfo) : int
      {
         var type:int = 0;
         var _loc3_:* = info.CategoryID;
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
                                                type = 0;
                                             }
                                          }
                                          type = 13;
                                       }
                                    }
                                    addr38:
                                    type = 1;
                                 }
                                 addr37:
                                 §§goto(addr38);
                              }
                              addr36:
                              §§goto(addr37);
                           }
                           addr35:
                           §§goto(addr36);
                        }
                        addr34:
                        §§goto(addr35);
                     }
                     addr33:
                     §§goto(addr34);
                  }
                  addr32:
                  §§goto(addr33);
               }
               addr31:
               §§goto(addr32);
            }
            §§goto(addr31);
         }
         else if(info.Property1 == "31")
         {
            type = 21;
         }
         else
         {
            type = 1;
         }
         return type;
      }
      
      private function onGetAllBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.getAllTreasure();
      }
      
      private function onConvertBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendConvertScore(false);
         TreasureControl.instance.isAlert = true;
      }
      
      private function onAlertResponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (event.currentTarget as BaseAlerFrame).removeEventListener("response",onAlertResponse);
         if(event.responseCode == 2 || event.responseCode == 3)
         {
            SocketManager.Instance.out.sendSellAll();
         }
         ObjectUtils.disposeObject(event.currentTarget);
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
