package welfareCenter.callBackLotteryDraw
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import welfareCenter.callBackLotteryDraw.view.CallBackLotteryDrawFrame;
   import welfareCenter.callBackLotteryDraw.view.FilterFrameTextMiddleLine;
   import welfareCenter.callBackLotteryDraw.view.LuckeyLotteryDrawFrame;
   
   public class CallBackLotteryDrawController extends EventDispatcher
   {
      
      private static var _instance:CallBackLotteryDrawController;
       
      
      private var _frame:Frame;
      
      public function CallBackLotteryDrawController(target:IEventDispatcher = null)
      {
         CallBackLotteryDrawFrame;
         LuckeyLotteryDrawFrame;
         super(target);
      }
      
      public static function get instance() : CallBackLotteryDrawController
      {
         if(_instance == null)
         {
            _instance = new CallBackLotteryDrawController();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         CallBackLotteryDrawManager.instance.addEventListener("event_open_frame",onOpenView);
         CallBackLotteryDrawManager.instance.addEventListener("event_zero_fresh",onZeroFresh);
      }
      
      protected function onOpenView(event:Event) : void
      {
         disposeFrame();
         if(CallBackLotteryDrawManager.instance.type == 1)
         {
            _frame = ComponentFactory.Instance.creatComponentByStylename("luckeylotterydraw.LuckeyLotteryDrawFrame");
            LayerManager.Instance.addToLayer(_frame,3,true,1);
         }
      }
      
      private function onZeroFresh(evt:Event) : void
      {
         if(_frame)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("callbacklotterdraw.zeroFresh"));
         }
         disposeFrame();
      }
      
      public function getCardShowFont(award:Object, stypeName:String) : Sprite
      {
         var info:InventoryItemInfo = award["InventoryItemInfo"];
         var sp:Sprite = new Sprite();
         UICreatShortcut.creatAndAdd(stypeName + ".pic6",sp);
         var goodName:String = info.Name;
         if(goodName.length > 6)
         {
            goodName = goodName.slice(0,4) + "...";
         }
         UICreatShortcut.creatTextAndAdd(stypeName + ".goodNameTf",goodName,sp);
         var bagCell:BagCell = new BagCell(1);
         bagCell.BGVisible = false;
         bagCell.setContentSize(60,60);
         bagCell.info = info;
         bagCell.setCount(info.Count);
         bagCell.x = 30;
         bagCell.y = 38;
         sp.addChild(bagCell);
         UICreatShortcut.creatAndAdd(stypeName + ".pic8",sp);
         var discountStr:String = LanguageMgr.GetTranslation("callbacklotterdraw.discoutTxt",award["LimitCount"] / 10);
         UICreatShortcut.creatTextAndAdd(stypeName + ".discountTf",discountStr,sp);
         var priceTf:FilterFrameText = ComponentFactory.Instance.creat(stypeName + ".priceTf");
         priceTf.text = LanguageMgr.GetTranslation("callbacklotterdraw.priceTxt",award["Cost"]);
         var priceTfX:int = priceTf.x;
         var priceTfY:int = priceTf.y;
         priceTf.x = 0;
         priceTf.y = 0;
         var priceTfLine:FilterFrameTextMiddleLine = new FilterFrameTextMiddleLine(priceTf);
         priceTfLine.x = priceTfX;
         priceTfLine.y = priceTfY;
         priceTfLine.drawMiddleLine(1,priceTf.textColor,1,4,priceTf.text.length - 1);
         sp.addChild(priceTfLine);
         var newPrice:int = award["Cost"] * award["LimitCount"] / 100;
         UICreatShortcut.creatTextAndAdd(stypeName + ".newPriceTf",LanguageMgr.GetTranslation("callbacklotterdraw.newPriceTxt",newPrice),sp);
         var ticketIcon1:Bitmap = UICreatShortcut.creatAndAdd("asset.ddtshop.PayTypeLabelTicket",sp);
         ticketIcon1.scaleX = 0.6;
         ticketIcon1.scaleY = 0.6;
         PositionUtils.setPos(ticketIcon1,stypeName + ".ticketIcon1");
         var ticketIcon2:Bitmap = UICreatShortcut.creatAndAdd("asset.ddtshop.PayTypeLabelTicket",sp);
         ticketIcon2.scaleX = 0.6;
         ticketIcon2.scaleY = 0.6;
         PositionUtils.setPos(ticketIcon2,stypeName + ".ticketIcon2");
         return sp;
      }
      
      public function disposeFrame() : void
      {
         if(_frame)
         {
            _frame.dispose();
            _frame = null;
         }
      }
   }
}
