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
      
      public function setData(param1:int) : void
      {
         _index = param1;
         _callBackModel = ConsortionModelManager.Instance.model.callBackModel;
         var _loc2_:Object = _callBackModel.awardArr[_index];
         UICreatShortcut.creatTextAndAdd("consortion.callBackView.conTf",LanguageMgr.GetTranslation("consortion.callBackView.con",_loc2_["backCount"]),this);
         var _loc3_:int = _callBackModel.callBackCount > _loc2_["backCount"]?_loc2_["backCount"]:_callBackModel.callBackCount;
         UICreatShortcut.creatTextAndAdd("consortion.callBackView.CountTf",_loc3_ + "/" + _loc2_["backCount"],this);
         _itemCell.info = _loc2_["itemTemplateInfo"];
         _itemCell.setCount(_loc2_["itemTemplateInfo"].Count);
         if(_callBackModel.awardStateMap[_loc2_["awardID"]])
         {
            _completeFlag.visible = true;
         }
         else
         {
            _completeFlag.visible = false;
            if(leftCallBackCount() >= _loc2_["backCount"])
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
         var _loc1_:int = _callBackModel.callBackCount;
         return _loc1_;
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var _loc2_:Object = _callBackModel.awardArr[_index];
         if(leftCallBackCount() >= _loc2_["backCount"])
         {
            SoundManager.instance.playButtonSound();
            SocketManager.Instance.out.getConsortionCallBackAward(_loc2_["awardID"]);
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
