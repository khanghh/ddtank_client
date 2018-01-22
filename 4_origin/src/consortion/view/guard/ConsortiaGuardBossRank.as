package consortion.view.guard
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortiaBossDataVo;
   import consortion.guard.ConsortiaGuardControl;
   import consortion.guard.ConsortiaGuardEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   
   public class ConsortiaGuardBossRank extends Sprite implements Disposeable
   {
       
      
      private const selectX:int = 983;
      
      private const unSelectX:int = 787;
      
      private var _bg:ScaleBitmapImage;
      
      private var _selectBtn:SelectedCheckButton;
      
      private var _openShow:Boolean = true;
      
      private var _titleText:FilterFrameText;
      
      private var _nameVBox:VBox;
      
      private var _valueVBox:VBox;
      
      private var _nameList:Vector.<FilterFrameText>;
      
      private var _valueList:Vector.<FilterFrameText>;
      
      public function ConsortiaGuardBossRank()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.rankViewBg");
         addChild(_bg);
         _selectBtn = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.rankViewSelectBtn");
         addChild(_selectBtn);
         _titleText = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.rank.titleText");
         _titleText.text = LanguageMgr.GetTranslation("tank.consortiaGurad.rankTitleText");
         addChild(_titleText);
         _nameVBox = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.rank.nameVBox");
         addChild(_nameVBox);
         _valueVBox = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.rank.valueVBox");
         addChild(_valueVBox);
         _nameList = new Vector.<FilterFrameText>();
         _valueList = new Vector.<FilterFrameText>();
         _loc3_ = 0;
         while(_loc3_ < 10)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.rank.nameText");
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.rank.rankText");
            _nameList.push(_loc2_);
            _valueList.push(_loc1_);
            _nameVBox.addChild(_loc2_);
            _valueVBox.addChild(_loc1_);
            _loc3_++;
         }
         this.x = 787;
         __onUpdateRank(null);
      }
      
      private function __onSelectClikc(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         updateRankPos();
      }
      
      private function updateRankPos() : void
      {
         var _loc1_:int = 0;
         if(_selectBtn.selected)
         {
            _loc1_ = 983;
         }
         else
         {
            _loc1_ = 787;
         }
         TweenLite.killTweensOf(this,true);
         TweenLite.to(this,0.5,{"x":_loc1_});
      }
      
      private function __onUpdateRank(param1:ConsortiaGuardEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:DictionaryData = ConsortiaGuardControl.Instance.model.rankList;
         _loc4_ = 0;
         while(_loc4_ < 10)
         {
            _loc3_ = _loc2_[_loc4_ + 1] as ConsortiaBossDataVo;
            if(_loc3_)
            {
               _nameList[_loc4_].text = _loc3_.rank + "." + _loc3_.name;
               _valueList[_loc4_].text = _loc3_.damage.toString();
            }
            else
            {
               _nameList[_loc4_].text = "";
               _valueList[_loc4_].text = "";
            }
            _loc4_++;
         }
         _nameVBox.arrange();
         _valueVBox.arrange();
      }
      
      private function initEvent() : void
      {
         _selectBtn.addEventListener("click",__onSelectClikc);
         ConsortiaGuardControl.Instance.addEventListener("updateRank",__onUpdateRank);
      }
      
      private function removeEvent() : void
      {
         _selectBtn.removeEventListener("click",__onSelectClikc);
         ConsortiaGuardControl.Instance.removeEventListener("updateRank",__onUpdateRank);
      }
      
      public function dispose() : void
      {
         removeEvent();
         TweenLite.killTweensOf(this);
         ObjectUtils.disposeObject(_nameVBox);
         ObjectUtils.disposeObject(_valueVBox);
         ObjectUtils.disposeAllChildren(this);
         _nameList = null;
         _valueList = null;
         _nameVBox = null;
         _valueVBox = null;
         _selectBtn = null;
         _bg = null;
      }
   }
}
