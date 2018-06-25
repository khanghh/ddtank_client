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
         var i:int = 0;
         var tmp:* = null;
         var j:int = 0;
         var nameTxt:* = null;
         var valueTxt:* = null;
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
         for(i = 0; i < 9; )
         {
            tmp = new HorseFrameLeftBottomStarCell();
            tmp.x = 76 + 35 * i;
            tmp.y = 319;
            addChild(tmp);
            _starCellList.push(tmp);
            i++;
         }
         _addPropertyValueTxtList = new Vector.<FilterFrameText>();
         var nameStrList:Array = LanguageMgr.GetTranslation("horse.addPropertyNameStr").split(",");
         for(j = 0; j < 5; )
         {
            nameTxt = ComponentFactory.Instance.creatComponentByStylename("horse.frame.addPorpertyNameTxt");
            nameTxt.text = nameStrList[j];
            nameTxt.x = 28 + 123 * (j % 3);
            nameTxt.y = 376 + 29 * (int(j / 3));
            valueTxt = ComponentFactory.Instance.creatComponentByStylename("horse.frame.addPorpertyValueTxt");
            valueTxt.text = "0";
            valueTxt.x = 53 + 123 * (j % 3) + 51;
            valueTxt.y = 376 + 29 * (int(j / 3));
            _addPropertyValueTxtList.push(valueTxt);
            addChild(nameTxt);
            addChild(valueTxt);
            j++;
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
         var i:int = 0;
         var curHorse:int = int(_level / 10) + 1;
         _nameTxt.text = _horseNameStrList[curHorse - 1];
         _horseMc.gotoAndStop(curHorse);
         _levelTxt.text = (int(_level / 10 + 1)).toString();
         _starTxt.text = String(_level % 10);
         var startIndex:int = int(_level / 10) * 10;
         for(i = 0; i < 9; )
         {
            _starCellList[i].refreshView(startIndex + i + 1,_level);
            i++;
         }
         var tmp:HorseTemplateVo = HorseManager.instance.getHorseTemplateInfoByLevel(_level);
         if(tmp)
         {
            _addPropertyValueTxtList[0].text = tmp.AddDamage.toString();
            _addPropertyValueTxtList[1].text = tmp.AddGuard.toString();
            _addPropertyValueTxtList[2].text = tmp.AddBlood.toString();
            _addPropertyValueTxtList[3].text = tmp.MagicAttack.toString();
            _addPropertyValueTxtList[4].text = tmp.MagicDefence.toString();
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
      
      public function set info(value:PlayerInfo) : void
      {
         _level = value.curHorseLevel;
         _curRidingBookHorseID = value.MountsType;
         _horseAmuletTips.tipData = value;
         refreshView();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _horseAmuletTips = null;
      }
   }
}
