package treasurePuzzle.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextField;
   import treasurePuzzle.controller.TreasurePuzzleManager;
   import treasurePuzzle.data.TreasurePuzzlePiceData;
   import treasurePuzzle.data.TreasurePuzzleRewardData;
   
   public class TreasurePuzzleHelpView extends Frame
   {
       
      
      private var _view:Sprite;
      
      private var _bg:ScaleBitmapImage;
      
      private var _topBg:Bitmap;
      
      private var _downBg:Bitmap;
      
      private var _panel:ScrollPanel;
      
      private var _panel2:ScrollPanel;
      
      private var _vbox:VBox;
      
      public function TreasurePuzzleHelpView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _view = new Sprite();
         titleText = LanguageMgr.GetTranslation("treasurePuzzle.view.helpTitle");
         _bg = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.helpView.frameBg");
         _view.addChild(_bg);
         _topBg = ComponentFactory.Instance.creat("treasurePuzzle.treasurePuzzletopBg");
         _downBg = ComponentFactory.Instance.creat("treasurePuzzle.treasurePuzzledownBg");
         _view.addChild(_topBg);
         _view.addChild(_downBg);
         _panel = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.helpView.helpPanel");
         _view.addChild(_panel);
         _panel2 = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.helpView.helpPanel2");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.helpView.Vbox");
         _view.addChild(_panel2);
         addToContent(_view);
         createRewardContent();
         createContent();
         enterEnable = true;
         escEnable = true;
      }
      
      private function createRewardContent() : void
      {
         var _loc1_:int = TreasurePuzzleManager.Instance.model.dataArr.length;
         setRewardInfo(_loc1_);
      }
      
      private function setRewardInfo(param1:int) : void
      {
         var _loc18_:* = null;
         var _loc19_:* = null;
         var _loc22_:* = null;
         var _loc13_:int = 0;
         var _loc8_:* = null;
         var _loc7_:Boolean = false;
         var _loc15_:* = null;
         var _loc9_:int = 0;
         var _loc21_:* = null;
         var _loc14_:int = 0;
         var _loc16_:int = 0;
         var _loc2_:* = null;
         var _loc10_:int = 0;
         var _loc20_:* = null;
         var _loc4_:String = LanguageMgr.GetTranslation("treasurePUzzle.view.helpContentSJ") + LanguageMgr.GetTranslation("treasurePuzzle.view.helpContentTitleRed") + LanguageMgr.GetTranslation("treasurePUzzle.view.helpContentGet");
         var _loc6_:String = LanguageMgr.GetTranslation("treasurePUzzle.view.helpContentSJ") + LanguageMgr.GetTranslation("treasurePuzzle.view.helpContentTitleBlue") + LanguageMgr.GetTranslation("treasurePUzzle.view.helpContentGet");
         var _loc5_:String = LanguageMgr.GetTranslation("treasurePUzzle.view.helpContentSJ") + LanguageMgr.GetTranslation("treasurePuzzle.view.helpContentTitleYellow") + LanguageMgr.GetTranslation("treasurePUzzle.view.helpContentGet");
         var _loc12_:Array = [_loc4_,_loc6_,_loc5_];
         var _loc17_:String = "";
         _loc13_ = 0;
         while(_loc13_ < TreasurePuzzleManager.Instance.model.dataArr.length)
         {
            _loc8_ = TreasurePuzzleManager.Instance.model.dataArr[_loc13_];
            _loc7_ = _loc8_.isShiwu;
            if(_loc7_)
            {
               _loc17_ = _loc17_ + LanguageMgr.GetTranslation("treasurePuzzle.view.shiwuContent");
            }
            else
            {
               _loc15_ = _loc8_.rewardList;
               _loc9_ = 0;
               while(_loc9_ < _loc15_.length)
               {
                  _loc21_ = _loc15_[_loc9_];
                  _loc14_ = _loc21_.rewardId;
                  _loc16_ = _loc21_.rewardNum;
                  _loc2_ = ItemManager.Instance.getTemplateById(_loc14_).Name;
                  if(_loc9_ == 0)
                  {
                     _loc17_ = _loc17_ + (_loc2_ + "x" + _loc16_);
                  }
                  else
                  {
                     _loc17_ = _loc17_ + ("、" + _loc2_ + "x" + _loc16_);
                  }
                  _loc9_++;
               }
            }
            _loc17_ = _loc17_ + "/";
            _loc13_++;
         }
         var _loc23_:Array = _loc17_.split("/");
         _loc23_.splice(-1,1);
         _loc10_ = 0;
         while(_loc10_ < _loc23_.length)
         {
            _loc20_ = new TreasurePuzzleHelpContentItem(_loc10_,_loc12_[_loc10_],_loc23_[_loc10_]);
            _vbox.addChild(_loc20_);
            _loc10_++;
         }
         var _loc3_:Sprite = new Sprite();
         var _loc11_:TextField = new TextField();
         _loc11_.height = 50;
         _loc11_.text = "111";
         _loc3_.alpha = 0;
         _loc3_.addChild(_loc11_);
         _vbox.addChild(_loc3_);
         _panel2.setView(_vbox);
      }
      
      private function createContent() : void
      {
         var _loc1_:Sprite = new Sprite();
         var _loc2_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.helpView.contentTitle");
         _loc2_.text = LanguageMgr.GetTranslation("treasurePuzzle.view.helpContentTitle");
         _loc1_.addChild(_loc2_);
         var _loc3_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.helpView.contentText");
         _loc3_.text = LanguageMgr.GetTranslation("treasurePuzzle.view.helpContentText");
         _loc1_.addChild(_loc3_);
         _panel.setView(_loc1_);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",_response);
      }
      
      private function _response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 0 || param1.responseCode == 1 || param1.responseCode == 2)
         {
            close();
         }
      }
      
      private function close() : void
      {
         removeEventListener("response",_response);
         ObjectUtils.disposeObject(_view);
         ObjectUtils.disposeObject(this);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEventListener("response",_response);
         if(_bg)
         {
            _bg.dispose();
            _bg = null;
         }
         if(_view)
         {
            ObjectUtils.disposeObject(_view);
            _view = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
