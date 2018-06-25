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
         var i:int = 0;
         var taskArr:* = null;
         var itemPos:* = null;
         var j:int = 0;
         var towerItem:* = null;
         var good:* = null;
         var bagCellBg:* = null;
         var inventoryItemInfo:* = null;
         var bagCell:* = null;
         var getBtn:* = null;
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
         var noticeTf:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.tower.noticeTf");
         noticeTf.text = LanguageMgr.GetTranslation("ddQiYuan.tower.frame.noticeTfMsg");
         addToContent(noticeTf);
         var bagCellRow1Pos:Point = ComponentFactory.Instance.creatCustomObject("ddQiYuan.tower.bagCell.row1");
         var getBtnRow1Pos:Point = ComponentFactory.Instance.creatCustomObject("ddQiYuan.tower.getBtn.row1");
         var taskGroupArr:Array = _model.taskGroupArr;
         var rewardArr:Array = _model.towerTaskRewardArr;
         _btnArr = [];
         for(i = 0; i < taskGroupArr.length; )
         {
            taskArr = taskGroupArr[i];
            itemPos = ComponentFactory.Instance.creatCustomObject("ddQiYuan.tower.item.row" + (i + 1));
            for(j = 0; j < taskArr.length; )
            {
               towerItem = new TowerItem();
               towerItem.setData(taskArr[j]);
               towerItem.x = itemPos.x + 104 * j;
               towerItem.y = itemPos.y;
               addToContent(towerItem);
               j++;
            }
            good = rewardArr[i];
            bagCellBg = ComponentFactory.Instance.creat("ddQiYuan.tower.BagCellBg");
            inventoryItemInfo = DDQiYuanManager.instance.getInventoryItemInfo(good);
            bagCell = new BagCell(1,inventoryItemInfo,true,bagCellBg,false);
            bagCell.x = bagCellRow1Pos.x;
            bagCell.y = bagCellRow1Pos.y + 85 * i;
            bagCell.setCount(inventoryItemInfo.Count);
            addToContent(bagCell);
            getBtn = new SimpleBitmapButton();
            getBtn.x = getBtnRow1Pos.x;
            getBtn.y = getBtnRow1Pos.y + 85 * i;
            _btnArr.push(getBtn);
            setBtnState(i);
            addToContent(getBtn);
            i++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",responseHandler);
         DDQiYuanManager.instance.addEventListener("event_gain_bogu_task_reward_back",onGainRewardBack);
         var _loc3_:int = 0;
         var _loc2_:* = _btnArr;
         for each(var getBtn in _btnArr)
         {
            getBtn.addEventListener("click",onClick);
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
         for each(var getBtn in _btnArr)
         {
            getBtn.removeEventListener("click",onClick);
         }
         _timer.removeEventListener("timer",onTimerTick);
      }
      
      private function onTimerTick(evt:TimerEvent) : void
      {
         var day:int = 0;
         var hour:int = 0;
         var min:int = 0;
         var sec:int = 0;
         var nowDate:Date = TimeManager.Instance.Now();
         var leftSec:Number = _model.endTime.time - nowDate.time;
         if(leftSec > 0)
         {
            day = leftSec / 86400000;
            hour = leftSec % 86400000 / 3600000;
            min = leftSec % 3600000 / 60000;
            sec = leftSec % 60000 / 1000;
            _leftTimeTf.text = LanguageMgr.GetTranslation("ddQiYuan.tower.frame.leftTimeTfMsg",day,hour,min,sec);
         }
         else
         {
            _leftTimeTf.text = LanguageMgr.GetTranslation("ddQiYuan.tower.frame.leftTimeTfMsg",0,0,0,0);
            _timer.removeEventListener("timer",onTimerTick);
         }
      }
      
      private function onClick(evt:MouseEvent) : void
      {
         var getBtn:SimpleBitmapButton = evt.target as SimpleBitmapButton;
         var phase:int = _btnArr.indexOf(getBtn) + 1;
         SocketManager.Instance.out.getDDQiYuanTowerTaskReward(phase);
      }
      
      private function setBtnState(index:int) : void
      {
         var taskArr:* = null;
         var isAllComplete:Boolean = false;
         var getBtn:SimpleBitmapButton = _btnArr[index];
         var data:Object = _model.towerTaskRewardArr[index];
         if(data["hasGain"])
         {
            getBtn.backStyle = "DDQiYuan.Pic26";
            getBtn.enable = false;
            getBtn.mouseEnabled = false;
         }
         else
         {
            taskArr = _model.taskGroupArr[index];
            isAllComplete = true;
            var _loc8_:int = 0;
            var _loc7_:* = taskArr;
            for each(var task in taskArr)
            {
               if(task["currCount"] < task["needCount"])
               {
                  isAllComplete = false;
                  break;
               }
            }
            if(isAllComplete)
            {
               getBtn.backStyle = "DDQiYuan.Pic25";
               getBtn.enable = true;
               getBtn.mouseEnabled = true;
            }
            else
            {
               getBtn.backStyle = "DDQiYuan.Pic25";
               getBtn.enable = false;
               getBtn.mouseEnabled = false;
            }
         }
      }
      
      private function responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.playButtonSound();
            DDQiYuanController.instance.disposeTowerFrame();
         }
      }
      
      private function onGainRewardBack(evt:CEvent) : void
      {
         var phase:int = evt.data as int;
         setBtnState(phase - 1);
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
