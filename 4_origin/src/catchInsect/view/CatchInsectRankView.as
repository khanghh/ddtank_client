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
      
      public function CatchInsectRankView(param1:int)
      {
         _type = param1;
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
      
      protected function __updateSelfInfo(param1:CatchInsectEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         if(_loc2_ > 0)
         {
            _rankTxt.text = _loc2_.toString();
         }
         else
         {
            _rankTxt.text = LanguageMgr.GetTranslation("bombKing.outOfRank2");
         }
         _needTxt.text = _loc3_.readInt().toString();
      }
      
      protected function __updateRankInfo(param1:CatchInsectEvent) : void
      {
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc3_:* = null;
         clearItems();
         _listItem = new Vector.<CatchInsectRankCell>();
         var _loc4_:PackageIn = param1.pkg;
         var _loc6_:int = _loc4_.readInt();
         _loc8_ = 0;
         while(_loc8_ <= _loc6_ - 1)
         {
            _loc7_ = new CatchInsectRankInfo();
            _loc7_.place = _loc4_.readInt();
            _loc7_.score = _loc4_.readInt();
            _loc7_.name = _loc4_.readUTF();
            _loc7_.isVIP = _loc4_.readBoolean();
            if(_type == 0)
            {
               _loc2_ = ServerConfigManager.instance.catchInsectLocalTitle;
               if(_loc8_ <= _loc2_.length - 1)
               {
                  _loc7_.titleNum = _loc2_[_loc8_];
               }
            }
            else
            {
               _loc7_.area = _loc4_.readUTF();
               _loc5_ = ServerConfigManager.instance.catchInsectAreaTitle;
               if(_loc8_ <= _loc5_.length - 1)
               {
                  _loc7_.titleNum = _loc5_[_loc8_];
               }
            }
            _loc3_ = new CatchInsectRankCell(_type);
            _loc3_.setData(_loc7_);
            _vbox.addChild(_loc3_);
            _listItem.push(_loc3_);
            _loc8_++;
         }
         _scrollPanel.invalidateViewport();
      }
      
      private function clearItems() : void
      {
         var _loc1_:int = 0;
         _vbox.removeAllChild();
         _loc1_ = 0;
         while(_loc1_ <= _listItem.length - 1)
         {
            _listItem[_loc1_].dispose();
            _listItem[_loc1_] = null;
            _loc1_++;
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
         var _loc1_:int = 0;
         removeEvents();
         _loc1_ = 0;
         while(_loc1_ <= _listItem.length - 1)
         {
            ObjectUtils.disposeObject(_listItem[_loc1_]);
            _listItem[_loc1_] = null;
            _loc1_++;
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
