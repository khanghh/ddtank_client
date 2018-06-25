package demonChiYou.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import worldboss.player.RankingPersonInfo;
   
   public class RankingPersonInfoItem extends Sprite implements Disposeable
   {
       
      
      private var _txtName:FilterFrameText;
      
      private var _txtDamage:FilterFrameText;
      
      private var _ranking:FilterFrameText;
      
      private var _num:int;
      
      private var _personInfo:RankingPersonInfo;
      
      private var _bg:ScaleFrameImage;
      
      private var _bgLine:MutipleImage;
      
      private var _longBg:Boolean;
      
      public function RankingPersonInfoItem(ranking:int, personInfo:RankingPersonInfo, longBg:Boolean = false)
      {
         super();
         _num = ranking;
         _personInfo = personInfo;
         _longBg = longBg;
         _init();
      }
      
      private function _init() : void
      {
         if(_longBg)
         {
            _bg = ComponentFactory.Instance.creatComponentByStylename("demonChiYouAward.rankingItemBg");
         }
         else
         {
            _bg = ComponentFactory.Instance.creatComponentByStylename("demonChiYou.RankingItem.bg");
         }
         addChild(_bg);
         _num % 2 == 0?_bg.setFrame(1):_bg.setFrame(2);
         _bgLine = ComponentFactory.Instance.creatComponentByStylename("demonChiYou.ranking.ViewItemSeperators");
         addChild(_bgLine);
         _txtName = ComponentFactory.Instance.creat("demonChiYou.ranking.name");
         addChild(_txtName);
         _txtDamage = ComponentFactory.Instance.creat("demonChiYou.ranking.damage");
         addChild(_txtDamage);
         _ranking = ComponentFactory.Instance.creat("demonChiYou.ranking.num");
         addChild(_ranking);
         setValue();
      }
      
      private function setValue() : void
      {
         _txtName.text = _personInfo.name;
         _txtDamage.text = _personInfo.damage.toString();
         _ranking.text = _num.toString();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            this.parent.removeChild(this);
         }
         _bg = null;
         _bgLine = null;
         _txtName = null;
         _txtDamage = null;
         _ranking = null;
      }
   }
}
