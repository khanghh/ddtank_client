package catchInsect.view
{
   import catchInsect.CatchInsectManager;
   import catchInsect.componets.CatchInsectRankCell;
   import catchInsect.data.CatchInsectRankInfo;
   import catchInsect.event.CatchInsectEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import road7th.comm.PackageIn;
   
   public class CatchInsectRankView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _vbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _listItem:Vector.<CatchInsectRankCell>;
      
      private var _myRankImg:Bitmap;
      
      private var _txtBg:Scale9CornerImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nextDescTxt:FilterFrameText;
      
      private var _needTxt:FilterFrameText;
      
      private var _type:int;
      
      public function CatchInsectRankView(type:int)
      {
         _type = type;
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("catchInsect.rankBg");
         addChild(_bg);
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("catchInsect.titleTxt");
         addChild(_titleTxt);
         _vbox = ComponentFactory.Instance.creatComponentByStylename("catchInsect.indivPrize.vBox2");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("catchInsect.indivPrize.scrollpanel2");
         _scrollPanel.setView(_vbox);
         addChild(_scrollPanel);
         _myRankImg = ComponentFactory.Instance.creat("catchInsect.myRank");
         addChild(_myRankImg);
         _txtBg = ComponentFactory.Instance.creatComponentByStylename("catchInsect.txtBg");
         PositionUtils.setPos(_txtBg,"catchInsect.txtBgPos");
         addChild(_txtBg);
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("catchInsect.rankTxt");
         addChild(_rankTxt);
         _rankTxt.text = "10";
         _nextDescTxt = ComponentFactory.Instance.creatComponentByStylename("catchInsect.nextDescTxt");
         addChild(_nextDescTxt);
         _nextDescTxt.text = LanguageMgr.GetTranslation("catchInsect.rankDesc");
         _needTxt = ComponentFactory.Instance.creatComponentByStylename("catchInsect.nextTxt");
         addChild(_needTxt);
         _needTxt.text = "5862";
         switch(int(_type))
         {
            case 0:
               _titleTxt.text = LanguageMgr.GetTranslation("catchInsect.rankMenu1");
               break;
            case 1:
               _titleTxt.text = LanguageMgr.GetTranslation("catchInsect.rankMenu2");
         }
         _listItem = new Vector.<CatchInsectRankCell>();
      }
      
      private function initEvents() : void
      {
         switch(int(_type))
         {
            case 0:
               CatchInsectManager.instance.addEventListener("updateLocalRank",__updateRankInfo);
               CatchInsectManager.instance.addEventListener("localSelfInfo",__updateSelfInfo);
               break;
            case 1:
               CatchInsectManager.instance.addEventListener("updateAreaRank",__updateRankInfo);
               CatchInsectManager.instance.addEventListener("areaSelfInfo",__updateSelfInfo);
         }
      }
      
      protected function __updateSelfInfo(event:CatchInsectEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var rank:int = pkg.readInt();
         if(rank > 0)
         {
            _rankTxt.text = rank.toString();
         }
         else
         {
            _rankTxt.text = LanguageMgr.GetTranslation("bombKing.outOfRank2");
         }
         _needTxt.text = pkg.readInt().toString();
      }
      
      protected function __updateRankInfo(event:CatchInsectEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         var arr:* = null;
         var arr2:* = null;
         var cell:* = null;
         clearItems();
         _listItem = new Vector.<CatchInsectRankCell>();
         var pkg:PackageIn = event.pkg;
         var len:int = pkg.readInt();
         for(i = 0; i <= len - 1; )
         {
            info = new CatchInsectRankInfo();
            info.place = pkg.readInt();
            info.score = pkg.readInt();
            info.name = pkg.readUTF();
            info.isVIP = pkg.readBoolean();
            if(_type == 0)
            {
               arr = ServerConfigManager.instance.catchInsectLocalTitle;
               if(i <= arr.length - 1)
               {
                  info.titleNum = arr[i];
               }
            }
            else
            {
               info.area = pkg.readUTF();
               arr2 = ServerConfigManager.instance.catchInsectAreaTitle;
               if(i <= arr2.length - 1)
               {
                  info.titleNum = arr2[i];
               }
            }
            cell = new CatchInsectRankCell(_type);
            cell.setData(info);
            _vbox.addChild(cell);
            _listItem.push(cell);
            i++;
         }
         _scrollPanel.invalidateViewport();
      }
      
      private function clearItems() : void
      {
         var i:int = 0;
         _vbox.removeAllChild();
         for(i = 0; i <= _listItem.length - 1; )
         {
            _listItem[i].dispose();
            _listItem[i] = null;
            i++;
         }
      }
      
      private function removeEvents() : void
      {
         CatchInsectManager.instance.removeEventListener("updateAreaRank",__updateRankInfo);
         CatchInsectManager.instance.removeEventListener("areaSelfInfo",__updateSelfInfo);
         CatchInsectManager.instance.removeEventListener("updateLocalRank",__updateRankInfo);
         CatchInsectManager.instance.removeEventListener("localSelfInfo",__updateSelfInfo);
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         removeEvents();
         for(i = 0; i <= _listItem.length - 1; )
         {
            ObjectUtils.disposeObject(_listItem[i]);
            _listItem[i] = null;
            i++;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_myRankImg);
         _myRankImg = null;
         ObjectUtils.disposeObject(_needTxt);
         _needTxt = null;
         ObjectUtils.disposeObject(_nextDescTxt);
         _nextDescTxt = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_txtBg);
         _txtBg = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
      }
   }
}
