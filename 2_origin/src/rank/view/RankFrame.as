package rank.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import rank.RankManager;
   
   public class RankFrame extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _leftBorderbg:ScaleBitmapImage;
      
      private var _leftView:RankMenu;
      
      private var _rightView:RankRewardView;
      
      private var _activityTime:FilterFrameText;
      
      private var _acitvityEndInfo:FilterFrameText;
      
      public function RankFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("rank.view.scale9ImageBg");
         addToContent(_bg);
         _leftBorderbg = ComponentFactory.Instance.creatComponentByStylename("rank.view.BG1");
         addToContent(_leftBorderbg);
         _leftView = new RankMenu();
         addToContent(_leftView);
         PositionUtils.setPos(_leftView,"rank.leftView.pos");
         _rightView = new RankRewardView();
         addToContent(_rightView);
         PositionUtils.setPos(_rightView,"rank.rightView.pos");
         _activityTime = ComponentFactory.Instance.creatComponentByStylename("rank.ActivityTimeText");
         addToContent(_activityTime);
         _activityTime.text = LanguageMgr.GetTranslation("ddt.rankFrame.activityTime",RankManager.instance.model.beginTime + "--" + RankManager.instance.model.endTime);
         _acitvityEndInfo = ComponentFactory.Instance.creatComponentByStylename("rank.AcitvityEndInfoText");
         addToContent(_acitvityEndInfo);
         _acitvityEndInfo.text = LanguageMgr.GetTranslation("ddt.rankFrame.endActivity");
      }
      
      public function init() : void
      {
         _leftView.init();
      }
      
      public function setRightView() : void
      {
         _rightView.setData();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_responseHandle);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",_responseHandle);
      }
      
      protected function _responseHandle(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
               break;
            default:
               dispose();
               break;
            default:
               dispose();
               break;
            case 4:
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_leftBorderbg);
         _leftBorderbg = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         ObjectUtils.disposeObject(_activityTime);
         _activityTime = null;
         ObjectUtils.disposeObject(_acitvityEndInfo);
         _acitvityEndInfo = null;
      }
   }
}
