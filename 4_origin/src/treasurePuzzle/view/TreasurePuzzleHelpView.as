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
         var titleNum:int = TreasurePuzzleManager.Instance.model.dataArr.length;
         setRewardInfo(titleNum);
      }
      
      private function setRewardInfo(type:int) : void
      {
         var content1:* = null;
         var content2:* = null;
         var content3:* = null;
         var i:int = 0;
         var data:* = null;
         var isShiwu:Boolean = false;
         var rewardList:* = null;
         var j:int = 0;
         var rewardData:* = null;
         var id:int = 0;
         var num:int = 0;
         var itemName:* = null;
         var k:int = 0;
         var treasureItem:* = null;
         var title1:String = LanguageMgr.GetTranslation("treasurePUzzle.view.helpContentSJ") + LanguageMgr.GetTranslation("treasurePuzzle.view.helpContentTitleRed") + LanguageMgr.GetTranslation("treasurePUzzle.view.helpContentGet");
         var title2:String = LanguageMgr.GetTranslation("treasurePUzzle.view.helpContentSJ") + LanguageMgr.GetTranslation("treasurePuzzle.view.helpContentTitleBlue") + LanguageMgr.GetTranslation("treasurePUzzle.view.helpContentGet");
         var title3:String = LanguageMgr.GetTranslation("treasurePUzzle.view.helpContentSJ") + LanguageMgr.GetTranslation("treasurePuzzle.view.helpContentTitleYellow") + LanguageMgr.GetTranslation("treasurePUzzle.view.helpContentGet");
         var titleArr:Array = [title1,title2,title3];
         var str:String = "";
         for(i = 0; i < TreasurePuzzleManager.Instance.model.dataArr.length; )
         {
            data = TreasurePuzzleManager.Instance.model.dataArr[i];
            isShiwu = data.isShiwu;
            if(isShiwu)
            {
               str = str + LanguageMgr.GetTranslation("treasurePuzzle.view.shiwuContent");
            }
            else
            {
               rewardList = data.rewardList;
               for(j = 0; j < rewardList.length; )
               {
                  rewardData = rewardList[j];
                  id = rewardData.rewardId;
                  num = rewardData.rewardNum;
                  itemName = ItemManager.Instance.getTemplateById(id).Name;
                  if(j == 0)
                  {
                     str = str + (itemName + "x" + num);
                  }
                  else
                  {
                     str = str + ("、" + itemName + "x" + num);
                  }
                  j++;
               }
            }
            str = str + "/";
            i++;
         }
         var strArr:Array = str.split("/");
         strArr.splice(-1,1);
         for(k = 0; k < strArr.length; )
         {
            treasureItem = new TreasurePuzzleHelpContentItem(k,titleArr[k],strArr[k]);
            _vbox.addChild(treasureItem);
            k++;
         }
         var sp:Sprite = new Sprite();
         var txt:TextField = new TextField();
         txt.height = 50;
         txt.text = "111";
         sp.alpha = 0;
         sp.addChild(txt);
         _vbox.addChild(sp);
         _panel2.setView(_vbox);
      }
      
      private function createContent() : void
      {
         var content:Sprite = new Sprite();
         var title:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.helpView.contentTitle");
         title.text = LanguageMgr.GetTranslation("treasurePuzzle.view.helpContentTitle");
         content.addChild(title);
         var contentText:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.helpView.contentText");
         contentText.text = LanguageMgr.GetTranslation("treasurePuzzle.view.helpContentText");
         content.addChild(contentText);
         _panel.setView(content);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",_response);
      }
      
      private function _response(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(e.responseCode == 0 || e.responseCode == 1 || e.responseCode == 2)
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
