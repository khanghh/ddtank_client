package consortion.view.selfConsortia
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.data.CallBackModel;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class CallBackItem extends Sprite implements Disposeable
   {
       
      
      private var _itemCell:BagCell;
      
      private var _index:int;
      
      private var _callBackModel:CallBackModel;
      
      private var _completeFlag:Bitmap;
      
      public function CallBackItem()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         UICreatShortcut.creatAndAdd("asset.consortion.weekRewardBg",this);
         _itemCell = new BagCell(1,null,true,null,true);
         _itemCell.PicPos = new Point(2,2);
         _itemCell.setContentSize(28,28);
         PositionUtils.setPos(_itemCell,"consort.callBackView.rewardCellPos");
         _itemCell.BGVisible = false;
         addChild(_itemCell);
         _completeFlag = UICreatShortcut.creatAndAdd("asset.placardAndEvent.callback6",this);
         _completeFlag.visible = false;
      }
      
      public function setData(index:int) : void
      {
         _index = index;
         _callBackModel = ConsortionModelManager.Instance.model.callBackModel;
         var award:Object = _callBackModel.awardArr[_index];
         UICreatShortcut.creatTextAndAdd("consortion.callBackView.conTf",LanguageMgr.GetTranslation("consortion.callBackView.con",award["backCount"]),this);
         var conditionCount:int = _callBackModel.callBackCount > award["backCount"]?award["backCount"]:_callBackModel.callBackCount;
         UICreatShortcut.creatTextAndAdd("consortion.callBackView.CountTf",conditionCount + "/" + award["backCount"],this);
         _itemCell.info = award["itemTemplateInfo"];
         _itemCell.setCount(award["itemTemplateInfo"].Count);
         if(_callBackModel.awardStateMap[award["awardID"]])
         {
            _completeFlag.visible = true;
         }
         else
         {
            _completeFlag.visible = false;
            if(leftCallBackCount() >= award["backCount"])
            {
               _itemCell.lightPic();
               _itemCell.addEventListener("click",onClick);
            }
            else
            {
               _itemCell.grayPic();
            }
         }
      }
      
      private function leftCallBackCount() : int
      {
         var leftCount:int = _callBackModel.callBackCount;
         return leftCount;
      }
      
      private function onClick(evt:MouseEvent) : void
      {
         var award:Object = _callBackModel.awardArr[_index];
         if(leftCallBackCount() >= award["backCount"])
         {
            SoundManager.instance.playButtonSound();
            SocketManager.Instance.out.getConsortionCallBackAward(award["awardID"]);
         }
      }
      
      public function dispose() : void
      {
         _itemCell.removeEventListener("click",onClick);
         ObjectUtils.disposeAllChildren(this);
         _itemCell = null;
         _callBackModel = null;
         _completeFlag = null;
      }
   }
}
