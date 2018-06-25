package petsBag.petsAdvanced
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import pet.data.PetInfo;
   import petsBag.petsAdvanced.event.PetsAdvancedEvent;
   import petsBag.view.item.PetBigItem;
   import petsBag.view.item.StarBar;
   
   public class PetsBasicInfoView extends Sprite implements Disposeable
   {
       
      
      private var _petName:FilterFrameText;
      
      private var _starBar:StarBar;
      
      private var _lv:Bitmap;
      
      private var _lvTxt:FilterFrameText;
      
      private var _petBigItem:PetBigItem;
      
      private var _advancedMc:MovieClip;
      
      private var _times:int = 0;
      
      public function PetsBasicInfoView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function addEvent() : void
      {
         addEventListener("starOrGrade_movie_complete",__movieHandler);
      }
      
      protected function __movieHandler(event:PetsAdvancedEvent) : void
      {
         _advancedMc = ComponentFactory.Instance.creat("petsBag.advanced.AdvancedMc");
         addChild(_advancedMc);
         PositionUtils.setPos(_advancedMc,"petsBag.advaced.advancedMcPos");
         addEventListener("enterFrame",__enterFrame);
      }
      
      protected function __enterFrame(event:Event) : void
      {
         if(_advancedMc && _advancedMc.currentFrame >= 22)
         {
            _times = Number(_times) + 1;
            if(_times == 3)
            {
               _times = 0;
               _advancedMc.stop();
               removeChild(_advancedMc);
               removeEventListener("enterFrame",__enterFrame);
               dispatchEvent(new PetsAdvancedEvent("all_movie_complete"));
            }
         }
      }
      
      private function initView() : void
      {
         _petName = ComponentFactory.Instance.creatComponentByStylename("petsBag.text.PetName");
         addChild(_petName);
         PositionUtils.setPos(_petName,"petsBag.advaced.petNamePos");
         _lv = ComponentFactory.Instance.creatBitmap("assets.petsBag.Lv");
         addChild(_lv);
         PositionUtils.setPos(_lv,"petsBag.advaced.lvBitmapPos");
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.text.Lv");
         addChild(_lvTxt);
         PositionUtils.setPos(_lvTxt,"petsBag.advaced.lvTxtPos");
         _starBar = new StarBar();
         PositionUtils.setPos(_starBar,"petsBag.advaced.starBarPos");
         addChild(_starBar);
         _petBigItem = new PetBigItem();
         PositionUtils.setPos(_petBigItem,"petsBag.advaced.petBigItemPos");
         addChild(_petBigItem);
      }
      
      public function setInfo(info:PetInfo) : void
      {
         _petName.text = info.Name;
         _lvTxt.text = !!info?info.Level.toString():"";
         _starBar.starNum(!!info?info.StarLevel:0);
         _petBigItem.info = info;
         _petBigItem.initTips();
         if(_petBigItem.fightImg)
         {
            _petBigItem.fightImg.visible = false;
         }
      }
      
      public function updateStar(starLevel:int) : void
      {
         _starBar.starNum(starLevel);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("starOrGrade_movie_complete",__movieHandler);
         removeEventListener("enterFrame",__enterFrame);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_petName);
         _petName = null;
         ObjectUtils.disposeObject(_lv);
         _lv = null;
         ObjectUtils.disposeObject(_lvTxt);
         _lvTxt = null;
         ObjectUtils.disposeObject(_starBar);
         _starBar = null;
         ObjectUtils.disposeObject(_petBigItem);
         _petBigItem = null;
         ObjectUtils.disposeObject(_advancedMc);
         _advancedMc = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
