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
      
      public function LotteryTicketCell(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function deleteBtnHandler(param1:MouseEvent) : void{}
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
      
      private function updateViewData() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
