package HappyRecharge
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class HappyRechargeExchangeView extends Sprite implements Disposeable
   {
       
      
      private var _cell:BagCell;
      
      private var _dirTxt:FilterFrameText;
      
      private var _numTxt:FilterFrameText;
      
      private var _ticket:Bitmap;
      
      private var _exchangeBtn:SimpleBitmapButton;
      
      private var _selfCount:int;
      
      private var _needCount:int;
      
      public function HappyRechargeExchangeView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _createCell();
         _dirTxt = ComponentFactory.Instance.creatComponentByStylename("exchangeview.dirTxt");
         _dirTxt.text = LanguageMgr.GetTranslation("happyRecharge.exchangeView.dirTxt");
         addChild(_dirTxt);
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("exchangeview.numTxt");
         _numTxt.text = LanguageMgr.GetTranslation("happyRecharge.exchangeView.numTxt",0,0);
         addChild(_numTxt);
         _ticket = ComponentFactory.Instance.creatBitmap("happyRecharge.exchangeView.ticket");
         PositionUtils.setPos(_ticket,"exchangeView.ticket.pos");
         addChild(_ticket);
         _exchangeBtn = ComponentFactory.Instance.creatComponentByStylename("exchangeview.exchangeBtn");
         addChild(_exchangeBtn);
         _exchangeBtn.enable = false;
      }
      
      private function initEvent() : void
      {
         _exchangeBtn.addEventListener("click",__exchangeHandler);
         HappyRechargeManager.instance.addEventListener("HAPPYRECHARGE_UPDATE_TICKET",__updateTicketHandler);
      }
      
      private function removeEvent() : void
      {
         _exchangeBtn.removeEventListener("click",__exchangeHandler);
         HappyRechargeManager.instance.removeEventListener("HAPPYRECHARGE_UPDATE_TICKET",__updateTicketHandler);
      }
      
      private function __exchangeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(HappyRechargeManager.instance.mouseClickEnable)
         {
            if(_selfCount >= _needCount)
            {
               SocketManager.Instance.out.happyRechargeExchange(_needCount,_cell.info.TemplateID);
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("happyRecharge.mainFrame.ticketless"));
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("happyRecharge.mainFrame.inrolling"));
         }
      }
      
      private function __updateTicketHandler(param1:Event) : void
      {
         refreshView(HappyRechargeManager.instance.ticketCount);
      }
      
      private function _createCell() : void
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(61440,0);
         _loc1_.graphics.drawRect(0,0,33,33);
         _loc1_.graphics.endFill();
         _cell = new BagCell(0,null,true,_loc1_,false);
         addChild(_cell);
         _cell.setContentSize(33,33);
         PositionUtils.setPos(_cell,"exchangeView.cell.pos");
      }
      
      private function updateBtnEnable() : void
      {
         _exchangeBtn.enable = _selfCount >= _needCount?true:false;
      }
      
      public function setInfo(param1:ItemTemplateInfo, param2:int, param3:int, param4:int) : void
      {
         _cell.info = param1;
         _cell.PicPos = new Point(2,2);
         _selfCount = param3;
         _needCount = param4;
         _numTxt.text = LanguageMgr.GetTranslation("happyRecharge.exchangeView.numTxt",_selfCount,_needCount);
         updateBtnEnable();
      }
      
      public function refreshView(param1:int) : void
      {
         _selfCount = param1;
         _numTxt.text = LanguageMgr.GetTranslation("happyRecharge.exchangeView.numTxt",_selfCount,_needCount);
         updateBtnEnable();
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_cell);
         _cell = null;
         ObjectUtils.disposeObject(_dirTxt);
         _dirTxt = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_ticket);
         _ticket = null;
         ObjectUtils.disposeObject(_exchangeBtn);
         _exchangeBtn = null;
      }
   }
}
