import React, { useState } from 'react';
import { supabase, APP_KEY } from '../supabaseClient';

export default function FormCours({ moniteurs, fetchData }) {
  const [date, setDate] = useState('');
  const [heure, setHeure] = useState('');
  const [type, setType] = useState('');
  const moniteur_default = moniteurs.find(m => m.prenom==='Claire')?.id || null;

  const handleSubmit = async (e) => {
    e.preventDefault();
    if(!moniteur_default) { alert('Moniteur par défaut manquant'); return; }
    await supabase.from('cours_instances').insert([
      { date, heure, type_cours: type, moniteur_id: moniteur_default, app_key: APP_KEY }
    ]);
    setDate(''); setHeure(''); setType('');
    fetchData();
  }

  return (
    <form onSubmit={handleSubmit}>
      <h3>Ajouter Cours</h3>
      <input type="date" value={date} onChange={e=>setDate(e.target.value)} required/>
      <input type="time" value={heure} onChange={e=>setHeure(e.target.value)} required/>
      <input type="text" value={type} onChange={e=>setType(e.target.value)} placeholder="Type cours" required/>
      <button type="submit">Ajouter</button>
    </form>
  )
}