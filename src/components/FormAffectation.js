import React, { useState } from 'react';
import { supabase, APP_KEY } from '../supabaseClient';

export default function FormAffectation({ cavaliers, equides, moniteurs, cours, fetchData }) {
  const [cours_id, setCoursId] = useState('');
  const [cavalier_id, setCavalierId] = useState('');
  const [equide_id, setEquideId] = useState('');
  const [moniteur_id, setMoniteurId] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    await supabase.from('affectations').insert([{
      cours_instance_id: cours_id,
      cavalier_id,
      equide_id,
      moniteur_id,
      app_key: APP_KEY
    }]);
    fetchData();
  }

  return (
    <form onSubmit={handleSubmit}>
      <h3>Affectation Cavalier → Cheval</h3>
      <select onChange={e=>setCoursId(e.target.value)} value={cours_id}>
        <option value="">Choisir cours</option>
        {cours.map(c=><option key={c.id} value={c.id}>{c.date} {c.heure} ({c.type_cours})</option>)}
      </select>
      <select onChange={e=>setCavalierId(e.target.value)} value={cavalier_id}>
        <option value="">Cavalier</option>
        {cavaliers.map(c=><option key={c.id} value={c.id}>{c.prenom}</option>)}
      </select>
      <select onChange={e=>setEquideId(e.target.value)} value={equide_id}>
        <option value="">Cheval</option>
        {equides.map(e=><option key={e.id} value={e.id}>{e.nom}</option>)}
      </select>
      <select onChange={e=>setMoniteurId(e.target.value)} value={moniteur_id}>
        <option value="">Moniteur</option>
        {moniteurs.map(m=><option key={m.id} value={m.id}>{m.prenom}</option>)}
      </select>
      <button type="submit">Ajouter</button>
    </form>
  )
}