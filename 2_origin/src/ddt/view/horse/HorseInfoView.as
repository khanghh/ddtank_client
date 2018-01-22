package ddt.view.horse
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import horse.HorseManager;
   import horse.data.HorseTemplateVo;
   
   public class HorseInfoView extends Sprite implements Disposeable
   {
       
      
      private var _level:int;
      
      private var _bg:Bitmap;
      
      private var _horseNameStrList:Array;
      
      private var _nameTxt:FilterFrameText;
      
      private var _horseMc:MovieClip;
      
      private var _levelStarTxtImage:Bitmap;
      
      private var _levelTxt:FilterFrameText;
      
      private var _starTxt:FilterFrameText;
      
      private var _starCellList:Vector.<HorseFrameLeftBottomStarCell>;
      
      private var _addPropertyValueTxtList:Vector.<FilterFrameText>;
      
      private var _curRidingBookHorseID:int;
      
      private var _bookHorseHeadBG:Bitmap;
      
      private var _bookHorseRidingState:FilterFrameText;
      
      private var _horseAmuletTips:Component;
      
      private var _bookRidingHeadBitmap:Bitmap;
      
      public function HorseInfoView()
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         super();
         this.mouseEnabled = false;
         _horseNameStrList = LanguageMgr.GetTranslation("horse.horseNameStr").split(",");
         _bg = ComponentFactory.Instance.creatBitmap("asset.horseInfoView.bg");
         addChild(_bg);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("horse.frame.horseNameTxt");
         addChild(_nameTxt);
         _horseMc = ComponentFactory.Instance.creat("asset.horse.frame.horseMc");
         PositionUtils.setPos(_horseMc,"horse.frame.horseMcPos");
         _horseMc.mouseChildren = false;
         _horseMc.mouseEnabled = false;
         _horseMc.gotoAndStop(_horseMc.totalFrames);
         addChild(_horseMc);
         _levelStarTxtImage = ComponentFactory.Instance.creatBitmap("asset.horse.frame.levelStarTxtImage");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("horse.frame.levelStarTxt");
         _starTxt = ComponentFactory.Instance.creatComponentByStylename("horse.frame.levelStarTxt");
         PositionUtils.setPos(_starTxt,"horse.frame.starTxtPos");
         _levelStarTxtImage.y = _levelStarTxtImage.y - 26;
         _levelTxt.y = _levelTxt.y - 26;
         _starTxt.y = _starTxt.y - 26;
         _bookHorseHeadBG = ComponentFactory.Instance.creatBitmap("asset.horse.bookHeadBG");
         _bookHorseHeadBG.x = 0;
         _bookHorseHeadBG.y = 10;
         _bookHorseRidingState = ComponentFactory.Instance.creat("horse.frame.BookRidingStateTxt");
         _bookHorseRidingState.text = LanguageMgr.GetTranslation("horse.bookRidingAHorse");
         addChild(_levelStarTxtImage);
         addChild(_levelTxt);
         addChild(_starTxt);
         addChild(_bookHorseHeadBG);
         addChild(_bookHorseRidingState);
         _starCellList = new Vector.<HorseFrameLeftBottomStarCell>();
         _loc6_ = 0;
         while(_loc6_ < 9)
         {
            _loc3_ = new HorseFrameLeftBottomStarCell();
            _loc3_.x = 76 + 35 * _loc6_;
            _loc3_.y = 319;
            addChild(_loc3_);
            _starCellList.push(_loc3_);
            _loc6_++;
         }
         _addPropertyValueTxtList = new Vector.<FilterFrameText>();
         var _loc5_:Array = LanguageMgr.GetTranslation("horse.addPropertyNameStr").split(",");
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("horse.frame.addPorpertyNameTxt");
            _loc2_.text = _loc5_[_loc4_];
            _loc2_.x = 28 + 123 * (_loc4_ % 3);
            _loc2_.y = 376 + 29 * (int(_loc4_ / 3));
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("horse.frame.addPorpertyValueTxt");
            _loc1_.text = "0";
            _loc1_.x = 53 + 123 * (_loc4_ % 3) + 51;
            _loc1_.y = 376 + 29 * (int(_loc4_ / 3));
            _addPropertyValueTxtList.push(_loc1_);
            addChild(_loc2_);
            addChild(_loc1_);
            _loc4_++;
         }
         _horseAmuletTips = ComponentFactory.Instance.creatComponentByStylename("ddtcorei.horseAmulet.tips");
         PositionUtils.setPos(_horseAmuletTips,"horse.amulet.playerTipsPos");
         _horseAmuletTips.graphics.beginFill(0,0);
         _horseAmuletTips.graphics.drawRect(0,0,200,200);
         _horseAmuletTips.graphics.endFill();
         addChild(_horseAmuletTips);
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = int(_level / 10) + 1;
         _nameTxt.text = _horseNameStrList[_loc2_ - 1];
         _horseMc.gotoAndStop(_loc2_);
         _levelTxt.text = (int(_level / 10 + 1)).toString();
         _starTxt.text = String(_level % 10);
         var _loc1_:int = int(_level / 10) * 10;
         _loc4_ = 0;
         while(_loc4_ < 9)
         {
            _starCellList[_loc4_].refreshView(_loc1_ + _loc4_ + 1,_level);
            _loc4_++;
         }
         var _loc3_:HorseTemplateVo = HorseManager.instance.getHorseTemplateInfoByLevel(_level);
         if(_loc3_)
         {
            _addPropertyValueTxtList[0].text = _loc3_.AddDamage.toString();
            _addPropertyValueTxtList[1].text = _loc3_.AddGuard.toString();
            _addPropertyValueTxtList[2].text = _loc3_.AddBlood.toString();
            _addPropertyValueTxtList[3].text = _loc3_.MagicAttack.toString();
            _addPropertyValueTxtList[4].text = _loc3_.MagicDefence.toString();
         }
         if(_bookRidingHeadBitmap != null && _bookRidingHeadBitmap.parent)
         {
            _bookRidingHeadBitmap.parent.removeChild(_bookRidingHeadBitmap);
            ObjectUtils.disposeObject(_bookRidingHeadBitmap);
         }
         if(_curRidingBookHorseID > 100)
         {
            _bookHorseRidingState.text = LanguageMgr.GetTranslation("horse.bookRidingAHorse");
            _bookHorseRidingState.filterString = "horse.bookriding.on.filter";
            _bookHorseRidingState.textColor = 16771411;
            _bookRidingHeadBitmap = ComponentFactory.Instance.creatBitmap("asset.horse.hd" + _curRidingBookHorseID.toString());
         }
         else
         {
            _bookHorseRidingState.text = LanguageMgr.GetTranslation("horse.bookRidingNone");
            _bookHorseRidingState.filterString = "horse.bookriding.none.filter";
            _bookHorseRidingState.textColor = 12829635;
            _bookRidingHeadBitmap = ComponentFactory.Instance.creatBitmap("asset.horse.none");
         }
         addChild(_bookRidingHeadBitmap);
      }
      
      public function set info(param1:PlayerInfo) : void
      {
         _level = param1.curHorseLevel;
         _curRidingBookHorseID = param1.MountsType;
         _horseAmuletTips.tipData = param1;
         refreshView();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _horseAmuletTips = null;
      }
   }
}
