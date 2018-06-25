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
      
      private function __exchangeHandler(e:MouseEvent) : void
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
      
      private function __updateTicketHandler(e:Event) : void
      {
         refreshView(HappyRechargeManager.instance.ticketCount);
      }
      
      private function _createCell() : void
      {
         var bg:Sprite = new Sprite();
         bg.graphics.beginFill(61440,0);
         bg.graphics.drawRect(0,0,33,33);
         bg.graphics.endFill();
         _cell = new BagCell(0,null,true,bg,false);
         addChild(_cell);
         _cell.setContentSize(33,33);
         PositionUtils.setPos(_cell,"exchangeView.cell.pos");
      }
      
      private function updateBtnEnable() : void
      {
         _exchangeBtn.enable = _selfCount >= _needCount?true:false;
      }
      
      public function setInfo(info:ItemTemplateInfo, itemCount:int, selfCount:int, needCount:int) : void
      {
         _cell.info = info;
         _cell.PicPos = new Point(2,2);
         _selfCount = selfCount;
         _needCount = needCount;
         _numTxt.text = LanguageMgr.GetTranslation("happyRecharge.exchangeView.numTxt",_selfCount,_needCount);
         updateBtnEnable();
      }
      
      public function refreshView(selfCount:int) : void
      {
         _selfCount = selfCount;
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
