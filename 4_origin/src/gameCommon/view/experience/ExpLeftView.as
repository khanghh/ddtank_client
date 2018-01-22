package gameCommon.view.experience
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.character.ShowCharacter;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.filters.BlurFilter;
   import flash.filters.GlowFilter;
   import gameCommon.GameControl;
   import gameCommon.model.Player;
   
   public class ExpLeftView extends Sprite implements Disposeable
   {
       
      
      private var _bigCharacter:Bitmap;
      
      private var _characterLight:MovieClip;
      
      private var _lightBg:Bitmap;
      
      private var _title:Bitmap;
      
      private var _bodyBg:Bitmap;
      
      private var _tabName:Bitmap;
      
      private var _tabExp:Bitmap;
      
      private var _tabExploit:Bitmap;
      
      private var _itemList:Vector.<ExpFriendItem>;
      
      private var _playersList:Vector.<Player>;
      
      private var _glowFilter:GlowFilter;
      
      private var _blurFilter:BlurFilter;
      
      public function ExpLeftView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         var _loc2_:int = 0;
         _itemList = new Vector.<ExpFriendItem>();
         _glowFilter = new GlowFilter(16750848,1,3,3,1);
         _blurFilter = new BlurFilter(5,5);
         var _loc1_:Boolean = false;
         _playersList = GameControl.Instance.Current.allias;
         _title = ComponentFactory.Instance.creatBitmap("asset.experience.friendViewTitleBg");
         _bodyBg = ComponentFactory.Instance.creatBitmap("asset.experience.friendViewBodyBg");
         _tabName = ComponentFactory.Instance.creatBitmap("asset.experience.tabName");
         _tabExp = ComponentFactory.Instance.creatBitmap("asset.experience.tabExp");
         if(GameControl.Instance.Current.roomType == 120)
         {
            _tabExploit = ComponentFactory.Instance.creatBitmap("asset.experience.prestigeTxt");
         }
         else
         {
            _tabExploit = ComponentFactory.Instance.creatBitmap("asset.experience.tabExploit");
         }
         _characterLight = ComponentFactory.Instance.creat("asset.experience.characterLight");
         _lightBg = ComponentFactory.Instance.creatBitmap("asset.experience.characterLightBg");
         var _loc3_:ShowCharacter = GameControl.Instance.Current.selfGamePlayer.character as ShowCharacter;
         if(GameControl.Instance.Current.selfGamePlayer.isWin)
         {
            _bigCharacter = new Bitmap(_loc3_.winCharater.clone());
            PositionUtils.setPos(_bigCharacter,"experience.LeftViewCharacterWinPos");
         }
         else
         {
            _bigCharacter = new Bitmap(_loc3_.charaterWithoutWeapon.clone());
            PositionUtils.setPos(_bigCharacter,"experience.LeftViewCharacterLosePos");
         }
         _bigCharacter.smoothing = true;
         _bigCharacter.scaleX = -1.44;
         _bigCharacter.scaleY = 1.44;
         PositionUtils.setPos(_characterLight,"experience.LeftViewCharacterLightPos");
         addChild(_lightBg);
         addChild(_characterLight);
         addChild(_bigCharacter);
         addChild(_title);
         addChild(_bodyBg);
         addChild(_tabName);
         addChild(_tabExp);
         addChild(_tabExploit);
         _loc2_ = 0;
         while(_loc2_ < _playersList.length)
         {
            _itemList.push(new ExpFriendItem(_playersList[_loc2_]));
            PositionUtils.setPos(_itemList[_loc2_],"experience.FriendItemPos_" + (String(_loc2_ + 1)));
            addChild(_itemList[_loc2_]);
            _loc2_++;
         }
         initEffect();
      }
      
      private function initEffect() : void
      {
         TweenMax.to(_glowFilter,0.8,{
            "startAt":{"color":16750848},
            "color":16737792,
            "yoyo":true,
            "repeat":-1,
            "onUpdate":updateFilter
         });
         TweenMax.to(_blurFilter,0.8,{
            "startAt":{
               "blurX":5,
               "blurY":5
            },
            "blurX":2,
            "blurY":2,
            "yoyo":true,
            "repeat":-1
         });
         TweenMax.to(_characterLight,0.8,{
            "startAt":{"alpha":0},
            "alpha":0.6,
            "yoyo":true,
            "repeat":-1
         });
      }
      
      private function updateFilter() : void
      {
         _characterLight.filters = [_glowFilter,_blurFilter];
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         TweenMax.killTweensOf(_glowFilter);
         if(_characterLight && _characterLight.parent)
         {
            _characterLight.parent.removeChild(_characterLight);
            _characterLight = null;
         }
         if(_bigCharacter && _bigCharacter.parent)
         {
            _bigCharacter.parent.removeChild(_bigCharacter);
            _bigCharacter = null;
         }
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
            _title = null;
         }
         if(_bodyBg)
         {
            ObjectUtils.disposeObject(_bodyBg);
            _bodyBg = null;
         }
         if(_tabName)
         {
            ObjectUtils.disposeObject(_tabName);
            _tabName = null;
         }
         if(_tabExp)
         {
            ObjectUtils.disposeObject(_tabExp);
            _tabExp = null;
         }
         if(_tabExploit)
         {
            ObjectUtils.disposeObject(_tabExploit);
            _tabExploit = null;
         }
         ObjectUtils.disposeObject(_lightBg);
         _lightBg = null;
         _loc1_ = 0;
         while(_loc1_ < _itemList.length)
         {
            _itemList[_loc1_].dispose();
            _itemList[_loc1_] = null;
            _loc1_++;
         }
         _blurFilter = null;
         _glowFilter = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
