package consortionBattle.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import consortionBattle.ConsortiaBattleManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ConsBatHideTip extends Sprite implements Disposeable
   {
      
      public static const SELECTED_CHANGE:String = "consBatHideTip_selected_change";
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _sameScb:SelectedCheckButton;
      
      private var _tombScb:SelectedCheckButton;
      
      private var _fightingScb:SelectedCheckButton;
      
      public function ConsBatHideTip()
      {
         super();
         initView();
         initEvent();
         updateTransform();
         _sameScb.selected = ConsortiaBattleManager.instance.isHide(1);
         _tombScb.selected = ConsortiaBattleManager.instance.isHide(2);
         _fightingScb.selected = ConsortiaBattleManager.instance.isHide(3);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         _sameScb = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.stripCheckBtn");
         _sameScb.text = LanguageMgr.GetTranslation("ddt.consortiaBattle.hideTip.sameTxt");
         _tombScb = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.stripCheckBtn");
         PositionUtils.setPos(_tombScb,"consortiaBattle.hideTombScbPos");
         _tombScb.text = LanguageMgr.GetTranslation("ddt.consortiaBattle.hideTip.tombTxt");
         _fightingScb = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.stripCheckBtn");
         PositionUtils.setPos(_fightingScb,"consortiaBattle.hideFightingScbPos");
         _fightingScb.text = LanguageMgr.GetTranslation("ddt.consortiaBattle.hideTip.fightingTxt");
         addChild(_bg);
         addChild(_sameScb);
         addChild(_tombScb);
         addChild(_fightingScb);
      }
      
      private function initEvent() : void
      {
         _sameScb.addEventListener("click",clickHandler,false,0,true);
         _tombScb.addEventListener("click",clickHandler,false,0,true);
         _fightingScb.addEventListener("click",clickHandler,false,0,true);
      }
      
      private function clickHandler(event:MouseEvent) : void
      {
         var tmpInt:int = 0;
         SoundManager.instance.play("008");
         var tmp:SelectedCheckButton = event.currentTarget as SelectedCheckButton;
         var _loc4_:* = tmp;
         if(_sameScb !== _loc4_)
         {
            if(_tombScb !== _loc4_)
            {
               if(_fightingScb !== _loc4_)
               {
                  tmpInt = 1;
               }
               else
               {
                  tmpInt = 3;
               }
            }
            else
            {
               tmpInt = 2;
            }
         }
         else
         {
            tmpInt = 1;
         }
         ConsortiaBattleManager.instance.changeHideRecord(tmpInt,tmp.selected);
         dispatchEvent(new Event("consBatHideTip_selected_change"));
      }
      
      public function hideAll() : void
      {
         _sameScb.selected = true;
         _tombScb.selected = true;
         _fightingScb.selected = true;
         ConsortiaBattleManager.instance.changeHideRecord(1,true);
         ConsortiaBattleManager.instance.changeHideRecord(2,true);
         ConsortiaBattleManager.instance.changeHideRecord(3,true);
      }
      
      public function showAll() : void
      {
         _sameScb.selected = false;
         _tombScb.selected = false;
         _fightingScb.selected = false;
         ConsortiaBattleManager.instance.changeHideRecord(1,false);
         ConsortiaBattleManager.instance.changeHideRecord(2,false);
         ConsortiaBattleManager.instance.changeHideRecord(3,false);
      }
      
      private function updateTransform() : void
      {
         var maxWidth:int = Math.max(_sameScb.width,_tombScb.width,_fightingScb.width);
         _bg.width = _sameScb.x + maxWidth + 15;
         _bg.height = _fightingScb.y + _fightingScb.height + 11;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _sameScb = null;
         _tombScb = null;
         _fightingScb = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
