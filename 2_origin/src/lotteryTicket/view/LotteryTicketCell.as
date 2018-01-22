package lotteryTicket.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import lotteryTicket.LotteryManager;
   import lotteryTicket.data.LotteryTicketInfo;
   import lotteryTicket.event.LotteryTicketEvent;
   
   public class LotteryTicketCell extends Sprite implements IListCell, Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var firstTicket:MovieClip;
      
      private var secondTicket:MovieClip;
      
      private var thirdTicket:MovieClip;
      
      private var fourthTicket:MovieClip;
      
      private var bought:Bitmap;
      
      private var deleteBtn:BaseButton;
      
      private var _data:LotteryTicketInfo;
      
      public function LotteryTicketCell()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.lotteryTicket.select.lightBg");
         addChild(_bg);
         var _loc1_:int = 0;
         firstTicket = ClassUtils.CreatInstance("asset.lotteryTicket.small.ticket");
         firstTicket.gotoAndStop(1);
         firstTicket.x = 5 + 46 * _loc1_;
         addChild(firstTicket);
         _loc1_++;
         secondTicket = ClassUtils.CreatInstance("asset.lotteryTicket.small.ticket");
         secondTicket.gotoAndStop(1);
         secondTicket.x = 5 + 46 * _loc1_;
         addChild(secondTicket);
         _loc1_++;
         thirdTicket = ClassUtils.CreatInstance("asset.lotteryTicket.small.ticket");
         thirdTicket.gotoAndStop(1);
         thirdTicket.x = 5 + 46 * _loc1_;
         addChild(thirdTicket);
         _loc1_++;
         fourthTicket = ClassUtils.CreatInstance("asset.lotteryTicket.small.ticket");
         fourthTicket.gotoAndStop(1);
         fourthTicket.x = 5 + 46 * _loc1_;
         addChild(fourthTicket);
         var _loc2_:* = 2;
         fourthTicket.y = _loc2_;
         _loc2_ = _loc2_;
         thirdTicket.y = _loc2_;
         _loc2_ = _loc2_;
         secondTicket.y = _loc2_;
         firstTicket.y = _loc2_;
         bought = ComponentFactory.Instance.creatBitmap("asset.lotteryTicket.bought");
         addChild(bought);
         bought.visible = false;
         deleteBtn = ComponentFactory.Instance.creatComponentByStylename("lotteryTicket.deleteBtn");
         addChild(deleteBtn);
         deleteBtn.visible = false;
      }
      
      private function initEvent() : void
      {
         deleteBtn.addEventListener("click",deleteBtnHandler);
      }
      
      private function deleteBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = LotteryManager.instance.model.dataList.indexOf(_data);
         LotteryManager.instance.model.dataList.splice(_loc2_,1);
         LotteryManager.instance.dispatchEvent(new LotteryTicketEvent("deleteCell"));
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         _data = param1 as LotteryTicketInfo;
         updateViewData();
      }
      
      private function updateViewData() : void
      {
         bought.visible = _data.ifBuy;
         deleteBtn.visible = !_data.ifBuy;
         firstTicket.gotoAndStop(parseInt(_data.ticketArr[0],16) + 1);
         secondTicket.gotoAndStop(parseInt(_data.ticketArr[1],16) + 1);
         thirdTicket.gotoAndStop(parseInt(_data.ticketArr[2],16) + 1);
         fourthTicket.gotoAndStop(parseInt(_data.ticketArr[3],16) + 1);
      }
      
      private function removeEvent() : void
      {
         deleteBtn.removeEventListener("click",deleteBtnHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(bought)
         {
            ObjectUtils.disposeObject(bought);
         }
         bought = null;
         if(deleteBtn)
         {
            ObjectUtils.disposeObject(deleteBtn);
         }
         deleteBtn = null;
         if(firstTicket)
         {
            ObjectUtils.disposeObject(firstTicket);
         }
         firstTicket = null;
         if(secondTicket)
         {
            ObjectUtils.disposeObject(secondTicket);
         }
         secondTicket = null;
         if(thirdTicket)
         {
            ObjectUtils.disposeObject(thirdTicket);
         }
         thirdTicket = null;
         if(fourthTicket)
         {
            ObjectUtils.disposeObject(fourthTicket);
         }
         fourthTicket = null;
      }
   }
}
