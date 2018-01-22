package ddQiYuan.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddQiYuan.DDQiYuanController;
   import ddQiYuan.DDQiYuanManager;
   import ddQiYuan.model.DDQiYuanModel;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelpFrameUtils;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class DDQiYuanTowerFrame extends Frame
   {
       
      
      private var _bg:Image;
      
      private var _btnHelp:BaseButton;
      
      private var _leftTimeTf:FilterFrameText;
      
      private var _model:DDQiYuanModel;
      
      private var _btnArr:Array;
      
      private var _timer:Timer;
      
      public function DDQiYuanTowerFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc8_:int = 0;
         var _loc3_:* = null;
         var _loc13_:* = null;
         var _loc7_:int = 0;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc11_:* = null;
         var _loc1_:* = null;
         var _loc5_:* = null;
         _model = DDQiYuanManager.instance.model;
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonSmall",{
            "x":798,
            "y":5
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"DDQiYuan.Tower.help",408,488);
         titleText = LanguageMgr.GetTranslation("ddQiYuan.tower.frame.titleText");
         _bg = ComponentFactory.Instance.creat("ddQiYuan.tower.bg");
         addToContent(_bg);
         _leftTimeTf = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.tower.leftTimeTf");
         addToContent(_leftTimeTf);
         var _loc14_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.tower.noticeTf");
         _loc14_.text = LanguageMgr.GetTranslation("ddQiYuan.tower.frame.noticeTfMsg");
         addToContent(_loc14_);
         var _loc12_:Point = ComponentFactory.Instance.creatCustomObject("ddQiYuan.tower.bagCell.row1");
         var _loc15_:Point = ComponentFactory.Instance.creatCustomObject("ddQiYuan.tower.getBtn.row1");
         var _loc9_:Array = _model.taskGroupArr;
         var _loc10_:Array = _model.towerTaskRewardArr;
         _btnArr = [];
         _loc8_ = 0;
         while(_loc8_ < _loc9_.length)
         {
            _loc3_ = _loc9_[_loc8_];
            _loc13_ = ComponentFactory.Instance.creatCustomObject("ddQiYuan.tower.item.row" + (_loc8_ + 1));
            _loc7_ = 0;
            while(_loc7_ < _loc3_.length)
            {
               _loc4_ = new TowerItem();
               _loc4_.setData(_loc3_[_loc7_]);
               _loc4_.x = _loc13_.x + 104 * _loc7_;
               _loc4_.y = _loc13_.y;
               addToContent(_loc4_);
               _loc7_++;
            }
            _loc6_ = _loc10_[_loc8_];
            _loc2_ = ComponentFactory.Instance.creat("ddQiYuan.tower.BagCellBg");
            _loc11_ = DDQiYuanManager.instance.getInventoryItemInfo(_loc6_);
            _loc1_ = new BagCell(1,_loc11_,true,_loc2_,false);
            _loc1_.x = _loc12_.x;
            _loc1_.y = _loc12_.y + 85 * _loc8_;
            _loc1_.setCount(_loc11_.Count);
            addToContent(_loc1_);
            _loc5_ = new SimpleBitmapButton();
            _loc5_.x = _loc15_.x;
            _loc5_.y = _loc15_.y + 85 * _loc8_;
            _btnArr.push(_loc5_);
            setBtnState(_loc8_);
            addToContent(_loc5_);
            _loc8_++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",responseHandler);
         DDQiYuanManager.instance.addEventListener("event_gain_bogu_task_reward_back",onGainRewardBack);
         var _loc3_:int = 0;
         var _loc2_:* = _btnArr;
         for each(var _loc1_ in _btnArr)
         {
            _loc1_.addEventListener("click",onClick);
         }
         _timer = new Timer(1000,2147483647);
         _timer.addEventListener("timer",onTimerTick);
         _timer.start();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",responseHandler);
         DDQiYuanManager.instance.removeEventListener("event_gain_bogu_task_reward_back",onGainRewardBack);
         var _loc3_:int = 0;
         var _loc2_:* = _btnArr;
         for each(var _loc1_ in _btnArr)
         {
            _loc1_.removeEventListener("click",onClick);
         }
         _timer.removeEventListener("timer",onTimerTick);
      }
      
      private function onTimerTick(param1:TimerEvent) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Date = TimeManager.Instance.Now();
         var _loc7_:Number = _model.endTime.time - _loc4_.time;
         if(_loc7_ > 0)
         {
            _loc6_ = _loc7_ / 86400000;
            _loc5_ = _loc7_ % 86400000 / 3600000;
            _loc2_ = _loc7_ % 3600000 / 60000;
            _loc3_ = _loc7_ % 60000 / 1000;
            _leftTimeTf.text = LanguageMgr.GetTranslation("ddQiYuan.tower.frame.leftTimeTfMsg",_loc6_,_loc5_,_loc2_,_loc3_);
         }
         else
         {
            _leftTimeTf.text = LanguageMgr.GetTranslation("ddQiYuan.tower.frame.leftTimeTfMsg",0,0,0,0);
            _timer.removeEventListener("timer",onTimerTick);
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var _loc2_:SimpleBitmapButton = param1.target as SimpleBitmapButton;
         var _loc3_:int = _btnArr.indexOf(_loc2_) + 1;
         SocketManager.Instance.out.getDDQiYuanTowerTaskReward(_loc3_);
      }
      
      private function setBtnState(param1:int) : void
      {
         var _loc2_:* = null;
         var _loc5_:Boolean = false;
         var _loc6_:SimpleBitmapButton = _btnArr[param1];
         var _loc4_:Object = _model.towerTaskRewardArr[param1];
         if(_loc4_["hasGain"])
         {
            _loc6_.backStyle = "DDQiYuan.Pic26";
            _loc6_.enable = false;
            _loc6_.mouseEnabled = false;
         }
         else
         {
            _loc2_ = _model.taskGroupArr[param1];
            _loc5_ = true;
            var _loc8_:int = 0;
            var _loc7_:* = _loc2_;
            for each(var _loc3_ in _loc2_)
            {
               if(_loc3_["currCount"] < _loc3_["needCount"])
               {
                  _loc5_ = false;
                  break;
               }
            }
            if(_loc5_)
            {
               _loc6_.backStyle = "DDQiYuan.Pic25";
               _loc6_.enable = true;
               _loc6_.mouseEnabled = true;
            }
            else
            {
               _loc6_.backStyle = "DDQiYuan.Pic25";
               _loc6_.enable = false;
               _loc6_.mouseEnabled = false;
            }
         }
      }
      
      private function responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.playButtonSound();
            DDQiYuanController.instance.disposeTowerFrame();
         }
      }
      
      private function onGainRewardBack(param1:CEvent) : void
      {
         var _loc2_:int = param1.data as int;
         setBtnState(_loc2_ - 1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _btnHelp = null;
         _leftTimeTf = null;
         _model = null;
         _btnArr = null;
         _timer = null;
      }
   }
}
