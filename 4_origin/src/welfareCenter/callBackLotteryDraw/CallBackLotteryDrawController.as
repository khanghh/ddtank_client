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
      
      public function CallBackLotteryDrawController(param1:IEventDispatcher = null)
      {
         CallBackLotteryDrawFrame;
         LuckeyLotteryDrawFrame;
         super(param1);
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
      
      protected function onOpenView(param1:Event) : void
      {
         disposeFrame();
         if(CallBackLotteryDrawManager.instance.type == 1)
         {
            _frame = ComponentFactory.Instance.creatComponentByStylename("luckeylotterydraw.LuckeyLotteryDrawFrame");
            LayerManager.Instance.addToLayer(_frame,3,true,1);
         }
      }
      
      private function onZeroFresh(param1:Event) : void
      {
         if(_frame)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("callbacklotterdraw.zeroFresh"));
         }
         disposeFrame();
      }
      
      public function getCardShowFont(param1:Object, param2:String) : Sprite
      {
         var _loc11_:InventoryItemInfo = param1["InventoryItemInfo"];
         var _loc5_:Sprite = new Sprite();
         UICreatShortcut.creatAndAdd(param2 + ".pic6",_loc5_);
         var _loc14_:String = _loc11_.Name;
         if(_loc14_.length > 6)
         {
            _loc14_ = _loc14_.slice(0,4) + "...";
         }
         UICreatShortcut.creatTextAndAdd(param2 + ".goodNameTf",_loc14_,_loc5_);
         var _loc4_:BagCell = new BagCell(1);
         _loc4_.BGVisible = false;
         _loc4_.setContentSize(60,60);
         _loc4_.info = _loc11_;
         _loc4_.setCount(_loc11_.Count);
         _loc4_.x = 30;
         _loc4_.y = 38;
         _loc5_.addChild(_loc4_);
         UICreatShortcut.creatAndAdd(param2 + ".pic8",_loc5_);
         var _loc3_:String = LanguageMgr.GetTranslation("callbacklotterdraw.discoutTxt",param1["LimitCount"] / 10);
         UICreatShortcut.creatTextAndAdd(param2 + ".discountTf",_loc3_,_loc5_);
         var _loc10_:FilterFrameText = ComponentFactory.Instance.creat(param2 + ".priceTf");
         _loc10_.text = LanguageMgr.GetTranslation("callbacklotterdraw.priceTxt",param1["Cost"]);
         var _loc13_:int = _loc10_.x;
         var _loc12_:int = _loc10_.y;
         _loc10_.x = 0;
         _loc10_.y = 0;
         var _loc7_:FilterFrameTextMiddleLine = new FilterFrameTextMiddleLine(_loc10_);
         _loc7_.x = _loc13_;
         _loc7_.y = _loc12_;
         _loc7_.drawMiddleLine(1,_loc10_.textColor,1,4,_loc10_.text.length - 1);
         _loc5_.addChild(_loc7_);
         var _loc6_:int = param1["Cost"] * param1["LimitCount"] / 100;
         UICreatShortcut.creatTextAndAdd(param2 + ".newPriceTf",LanguageMgr.GetTranslation("callbacklotterdraw.newPriceTxt",_loc6_),_loc5_);
         var _loc9_:Bitmap = UICreatShortcut.creatAndAdd("asset.ddtshop.PayTypeLabelTicket",_loc5_);
         _loc9_.scaleX = 0.6;
         _loc9_.scaleY = 0.6;
         PositionUtils.setPos(_loc9_,param2 + ".ticketIcon1");
         var _loc8_:Bitmap = UICreatShortcut.creatAndAdd("asset.ddtshop.PayTypeLabelTicket",_loc5_);
         _loc8_.scaleX = 0.6;
         _loc8_.scaleY = 0.6;
         PositionUtils.setPos(_loc8_,param2 + ".ticketIcon2");
         return _loc5_;
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
